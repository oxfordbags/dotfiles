"""detypo: replace MusicBrainz typographic punctuation with plain ASCII.

Two mechanisms:
  * Automatic: on the `write` event, rewrites both the tags written to the
    file *and* the in-memory item (so the DB row stored after import matches).
    This covers `beet import`, `beet mbsync`, `beet modify`, etc.
  * Manual: `beet detypo [QUERY]` force-rewrites existing items in the library
    (file tags + DB). Needed because `beet write` skips files whose tags
    already agree with the DB -- if both sides are typographic, nothing else
    would ever fix them.

Letters (accents, etc.) are never touched -- only punctuation/whitespace.
"""

from beets.plugins import BeetsPlugin
from beets import ui
from beets.ui import Subcommand, colorize

# Map of Unicode codepoint -> ASCII replacement string.
REPLACEMENTS = {
    # single quotes / apostrophes / primes
    0x2018: "'",  # ' left single quote
    0x2019: "'",  # ' right single quote (MB apostrophe)
    0x201A: "'",  # ‚ single low-9 quote
    0x201B: "'",  # ‛ single high-reversed-9 quote
    0x2032: "'",  # ′ prime
    0x2035: "'",  # ‵ reversed prime
    # double quotes / double primes
    0x201C: '"',  # " left double quote
    0x201D: '"',  # " right double quote
    0x201E: '"',  # „ double low-9 quote
    0x201F: '"',  # ‟ double high-reversed-9 quote
    0x2033: '"',  # ″ double prime
    0x2036: '"',  # ‶ reversed double prime
    # dashes / hyphens / minus
    0x2010: "-",  # ‐ hyphen
    0x2011: "-",  # ‑ non-breaking hyphen
    0x2012: "-",  # ‒ figure dash
    0x2013: "-",  # – en dash (common MB separator)
    0x2014: "-",  # — em dash
    0x2015: "-",  # ― horizontal bar
    0x2212: "-",  # − minus sign
    # ellipsis
    0x2026: "...",  # …
    # spaces -> normal space
    0x00A0: " ",  # no-break space
    0x2007: " ",  # figure space
    0x2009: " ",  # thin space
    0x202F: " ",  # narrow no-break space
    # zero-width / BOM -> remove
    0x200B: "",
    0x200C: "",
    0x200D: "",
    0xFEFF: "",
}


def detypo(value):
    """Return `value` with typographic punctuation replaced, or unchanged if
    it is not a string."""
    if not isinstance(value, str):
        return value
    return value.translate(REPLACEMENTS)


class DetypoPlugin(BeetsPlugin):
    def __init__(self):
        super().__init__()
        self.config.add({"auto": True, "fields": ["title", "album", "artist"]})
        if self.config["auto"].get(bool):
            self.register_listener("write", self.write_event)

    @property
    def fields(self):
        return set(self.config["fields"].as_str_seq())

    # --- automatic path -----------------------------------------------------

    def write_event(self, item, path, tags):
        """Rewrite typographic chars in the tags about to be written, and
        mirror the change onto the item so an ensuing store() persists it."""
        for field in self.fields:
            if field not in tags:
                continue
            value = tags[field]
            new = detypo(value)
            if new != value:
                tags[field] = new
                # keep the DB in sync; harmless if the item isn't stored.
                if field in item:
                    item[field] = new

    # --- manual command -----------------------------------------------------

    def commands(self):
        cmd = Subcommand(
            "detypo",
            help="replace typographic punctuation with ASCII in tags + DB",
        )
        cmd.parser.add_option(
            "-p",
            "--pretend",
            action="store_true",
            default=False,
            help="show what would change without writing anything",
        )
        cmd.parser.add_option(
            "-W",
            "--no-write",
            action="store_false",
            dest="write",
            default=True,
            help="update the database only; do not rewrite file tags",
        )
        cmd.func = self._run
        return [cmd]

    def _run(self, lib, opts, args):
        query = ui.decargs(args)
        changed = 0
        for item in lib.items(query):
            fields = self._item_changes(item)
            if not fields:
                continue
            changed += 1
            for field, (old, new) in fields.items():
                print(
                    f"{item.id}: {field}: "
                    f"{colorize('text_error', old)} -> "
                    f"{colorize('text_success', new)}"
                )
            if opts.pretend:
                continue
            for field, (_old, new) in fields.items():
                item[field] = new
            if opts.write:
                item.try_write()
            item.store()
        # Albums carry their own DB copy of album-level fields.
        for album in lib.albums(query):
            fields = self._album_changes(album)
            if not fields:
                continue
            for field, (old, new) in fields.items():
                print(
                    f"album {album.id}: {field}: "
                    f"{colorize('text_error', old)} -> "
                    f"{colorize('text_success', new)}"
                )
            if opts.pretend:
                continue
            for field, (_old, new) in fields.items():
                album[field] = new
            album.store()

        verb = "would change" if opts.pretend else "changed"
        print(f"detypo: {verb} {changed} item(s).")

    def _item_changes(self, item):
        return self._changes(item)

    def _album_changes(self, album):
        return self._changes(album)

    def _changes(self, obj):
        out = {}
        for field in self.fields:
            if field not in obj:
                continue
            old = obj[field]
            new = detypo(old)
            if new != old:
                out[field] = (old, new)
        return out

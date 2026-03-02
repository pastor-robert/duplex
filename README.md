# duplex

A simple shell script for manual duplex printing on printers that don't support automatic duplex.

## Usage

```sh
duplex [input.pdf] [lpr options...]
```

If no input file is specified, reads from stdin.

The script:
1. Splits the PDF into even and odd pages using `pdftk`
2. Prints the even pages first
3. Prompts you to flip the pages and load them into Tray 1
4. Prints the odd pages on the reverse side

## Dependencies

- `pdftk` - PDF toolkit for splitting pages
- `lpr` - CUPS printing command

## Configuration

The printer is hardcoded as `Hewlett-Packard_HP_Color_LaserJet_M553`. Edit the script to change the printer name for your setup.

## License

CC0 1.0 Universal - See [LICENSE](LICENSE)

---

*This README was written with assistance from Claude (claude-opus-4-5-20251101).*

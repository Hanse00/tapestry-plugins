name: Upload Tapestry Plugins
on:
  release:
    types: [created]
jobs:
  upload-plugins:
    name: Upload Tapestry Plugins to Release
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Repository
        uses: actions/checkout@v4
      - name: Create Archives
        run: |
          #!/bin/bash
          for dir in */; do
          if [[ ! -f "$dir/plugin-config.json" ]]; then continue; fi
            dir_name="${dir%/}"
            output_file="${dir_name}.tapestry"
            zip -r "$output_file" "$dir_name" -x "*.png"
          done
      - name: Upload Release Assets
        uses: softprops/action-gh-release@v2
        if: startsWith(github.ref, 'refs/tags/')
        with:
          files: *.tapestry

from pathlib import Path
import shutil

# Diretório onde estão os arquivos
base_dir = Path("../data/files")

# Mapeamento das extensões
folders = {
    ".txt": "text",
    ".log": "logs",
    ".json": "json",
    ".png": "images"
}

print("Organizing files...\n")

for file_path in base_dir.iterdir():

    if file_path.is_file():

        extension = file_path.suffix.lower()

        if extension in folders:

            destination_dir = base_dir / folders[extension]

            # Cria a pasta de destino
            destination_dir.mkdir(exist_ok=True)

            destination_file = destination_dir / file_path.name

            # Move o arquivo
            shutil.move(
                str(file_path),
                str(destination_file)
            )

            print(
                f"Moved: {file_path.name} "
                f"-> {destination_dir.name}/"
            )

        else:
            print(f"Unknown extension: {file_path.name}")

print("\nOrganization completed.")

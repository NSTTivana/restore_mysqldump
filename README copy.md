```markdown
# Database Restore Script

A simple Bash script to restore a single SQL file into multiple MySQL databases concurrently, with progress display. This script is ideal for scenarios where you need to populate multiple databases with the same data, such as testing environments or development setups.

---

## 🎯 Features
- **Single SQL File**: Restore one SQL file (`dump-xxxx.sql`) into multiple databases.
- **Concurrent Processing**: Runs each database restore task in the background to save time.
- **Progress Display**: Utilizes the `pv` command to show the restore progress for each database.

---

## 🛠️ Prerequisites
- **MySQL Client**: Ensure MySQL is installed and accessible from the command line.
- **pv Command**: This script requires `pv` to show the progress of the restoration process. Install `pv` by running:
  - Debian/Ubuntu: `sudo apt-get install pv`
  - macOS: `brew install pv`

---

## 📦 Setup
1. **Edit the `DATABASES` array** to list the databases you want to restore, e.g.:
   ```bash
   DATABASES=("database1" "database2" "database3")
   ```

2. **Update MySQL credentials**:
   - Set the `USER`, `PASSWORD`, and `HOST` variables with your MySQL credentials and host information.

3. **Place your SQL file**:
   - Save the SQL file in the `dump` folder and name it `dump-preview.sql` (or modify `DUMP_FILE` in the script to match your filename).

---

## 🚀 Usage

To run the script, use the following command:

```bash
./script.sh
```

This will restore the `dump-preview.sql` file into each database listed in `DATABASES`, running each restore task concurrently in the background.

### Example Script
Here’s the full script for reference:

```bash
#!/bin/bash

DATABASES=(
"database1"
"database2"
)

USER="username"
PASSWORD="password"
HOST="192.168.xx.x"
DUMP_FILE="dump/dump-xx.sql"  

restore_db() {
  DB=$1
  if [[ -f "$DUMP_FILE" ]]; then
    echo "Restoring $DB from $DUMP_FILE..."
    pv "$DUMP_FILE" | mysql --skip-ssl -h "$HOST" -u "$USER" -p"$PASSWORD" "$DB"
    echo "Completed $DB"
  else
    echo "SQL file $DUMP_FILE not found."
  fi
}

# Loop through the databases and restore each in the background
for DB in "${DATABASES[@]}"
do
  restore_db "$DB" &  # Run in the background
done


wait 
echo "All databases have been restored."
```

---

## ⚠️ Important Notes
- **Data Overwrite**: This script will overwrite existing data in the specified databases. Use caution when running on production databases.
- **SQL File Naming**: This script restores the same SQL file to all databases. If you need to use different SQL files, adjust the script accordingly.
- **Error Handling**: Ensure the `DUMP_FILE` path is correct; otherwise, the script will skip the restore process for each database.

---

## 📄 License
This project is open-source and available under the [MIT License](LICENSE).

---

## 💬 Contributing
Feel free to open issues or submit pull requests with improvements or bug fixes.

---
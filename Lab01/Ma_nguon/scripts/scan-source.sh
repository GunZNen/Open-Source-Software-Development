#!/usr/bin/env bash
set -u

# 1. KIỂM TRA ĐẦU VÀO (TODO 1)
target_dir="${1:-}"

if [[ -z "$target_dir" || ! -d "$target_dir" ]]; then
  echo "Lỗi: Thư mục không tồn tại hoặc không hợp lệ." >&2
  exit 2
fi

# 2. KHỞI TẠO VÀ TÌM TỆP PHP
total=0
pass=0
fail=0

php_files=()
while IFS= read -r -d '' file; do
  php_files+=("$file")
done < <(find "$target_dir" -type f -name "*.php" -print0)

# Kiểm tra thư mục rỗng / không có tệp PHP (TODO 3)
if [[ ${#php_files[@]} -eq 0 ]]; then
  echo "Không tìm thấy tệp PHP nào để kiểm tra."
  exit 2
fi

# 3. DUYỆT VÀ KIỂM TRA CÚ PHÁP TỪNG TỆP PHP (TODO 2)
for file in "${php_files[@]}"; do
  total=$((total + 1))
  
  if php -l "$file" >/dev/null 2>&1; then
    pass=$((pass + 1))
  else
    fail=$((fail + 1))
  fi
done

echo "TOTAL=$total PASS=$pass FAIL=$fail"

# 4. TRẢ MÃ THOÁT HỆ THỐNG (TODO 3)
if [[ "$fail" -gt 0 ]]; then
  exit 1
else
  exit 0
fi
<?php
declare(strict_types=1);

final class RegistrationPolicy
{
    public function decide(int $capacity, int $registered, bool $isOpen, bool $hasWaitingList): string
    {
        // 1. Kiểm tra dữ liệu không hợp lệ: sức chứa <= 0, số đã đăng ký âm hoặc vượt quá sức chứa
        if ($capacity <= 0 || $registered < 0 || $registered > $capacity) {
            return 'rejected';
        }

        // 2. Kiểm tra nếu sự kiện đã đóng thì từ chối, kể cả khi vẫn còn chỗ
        if (!$isOpen) {
            return 'rejected';
        }

        // 3. Nếu sự kiện mở và còn chỗ (số đăng ký nhỏ hơn sức chứa) -> xác nhận
        if ($registered < $capacity) {
            return 'confirmed';
        }

        // 4. Nếu sự kiện mở, đã đầy chỗ (registered === capacity):
        // Nếu có danh sách chờ -> waiting, nếu không có -> rejected
        if ($hasWaitingList) {
            return 'waiting';
        } else {
            return 'rejected';
        }
    }
}
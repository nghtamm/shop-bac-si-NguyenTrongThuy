# 💊 Ứng dụng di động cho hệ thống bán hàng Shop Bác sĩ Nguyễn Trọng Thủy

Bài tập lớn: Lập trình di động (Học kì 1 - Năm 4 - Học viện Ngân hàng)

Đồ án tốt nghiệp (Khóa 24 - Lớp niên chế K24CNTTA - Năm học 2021-2025)

## Mục lục

- [Thông tin cơ bản](#thông-tin-cơ-bản)
- [Techstack](#techstack)
- [Yêu cầu](#yêu-cầu)
- [Hướng dẫn sử dụng](#hướng-dẫn-sử-dụng)

## Thông tin cơ bản

Ứng dụng di động thương mại điện tử Shop Bác sĩ Nguyễn Trọng Thủy với các tính năng chính

- Đăng ký, đăng nhập, đăng xuất sử dụng API của plugin [Simple JWT Login](https://simplejwtlogin.com/), hỗ trợ mã hóa HS256 và đăng nhập bằng Google (thông qua OAuth 2.0)
- Giỏ hàng lưu trữ trên _bộ nhớ cục bộ (local storage)_ sử dụng [flutter_hive](https://pub.dev/packages/hive_flutter)
- Hệ thống e-commerce mua bán thực phẩm bổ sung với đầy đủ các tùy chọn (số lượng, biến thể), chia sẻ sản phẩm, danh sách yêu thích (sử dụng plugin [TI WooCommerce Wishlist](https://wordpress.org/plugins/ti-woocommerce-wishlist/)),...
- Tích hợp hệ thống thanh toán của [Casso VietQR](https://developer.casso.vn/)
- Xây dựng AI Agent hỗ trợ tư vấn sức khỏe cơ - xương - khớp và hỗ trợ bán hàng sử dụng [n8n Automation Workflow](https://app.n8n.cloud/login) và [API của OpenAI ChatGPT](https://openai.com/api/)
- Cập nhật kịp thời toàn bộ clip mới nhất của [Bác sĩ Nguyễn Trọng Thủy](https://www.youtube.com/@bacsinguyentrongthuystarsmec) sử dụng [Youtube Data API v3](https://developers.google.com/youtube/v3)
- Hệ quản trị nội dung (CMS) quản lý toàn bộ dữ liệu liên quan tới _accounts, customers, orders, products,..._ sử dụng dashboard quản trị viên của WooCommerce và [Pancake POS](https://pos.pancake.vn/dashboard)

### Disclaimer: Toàn bộ dữ liệu, thông tin và hình ảnh của dự án thuộc quyền sở hữu của doanh nghiệp Shop Bác sĩ Nguyễn Trọng Thủy và Trung tâm Y học Thể thao STARSEMC, vui lòng không sử dụng với mục đích cá nhân!

**Nhóm tác giả**

- [Nguyễn Hoàng Tâm](https://github.com/nghtamm)
- [Nguyễn Huy Phước](https://github.com/DurkYerunz)
- [Nguyễn Hải Sơn](https://github.com/lilMatthew)

## Techstack

- Ngôn ngữ lập trình Dart
- Flutter
- WordPress/WooCommerce
- n8n với OpenAI ChatGPT API
- Casso VietQR

## Yêu cầu

- Cài đặt [môi trường](https://docs.flutter.dev/get-started/install/windows/mobile) bao gồm Dart SDK, Flutter SDK, Android SDK, adb, cmd-tools,...
- Cài đặt [VSCode](https://code.visualstudio.com/), [Android Studio](https://developer.android.com/studio), [JetBrains IntelliJ IDEA](https://www.jetbrains.com/idea/) hoặc bất cứ IDE nào khác hỗ trợ

## Hướng dẫn sử dụng

Trước tiên, cài đặt toàn bộ các dependencies của dự án

```
flutter clean
flutter pub get
```

Sau đó, debug ứng dụng dưới chế độ **_--release_** hoặc đóng gói thành tệp **_.apk_** để cài đặt trên thiết bị Android

```
// Debug ứng dụng ở chế độ --release
flutter run --release

// Đóng gói tệp .apk
flutter build apk --release
```

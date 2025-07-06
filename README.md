# 👤 Modernist User App

Modern ve kullanıcı dostu bir iOS uygulaması ile kullanıcı yönetimi artık çok daha kolay!  
📱 Bu uygulama, [JSONPlaceholder](https://jsonplaceholder.typicode.com/users) API'si kullanarak kullanıcı verilerini görüntülemenize, aramanıza ve favorilerinizi organize etmenize olanak tanır.

---

## ✨ Özellikler

### 🎯 Temel Özellikler

- 👥 **Kullanıcı Listesi:** Tüm kullanıcıları listeleyin ve detaylarını görüntüleyin  
- 🔍 **Akıllı Arama:** İsim, e-posta veya kullanıcı adına göre hızlı arama  
- ❤️ **Favori Yönetimi:** Beğendiğiniz kullanıcıları favorilere ekleyin veya çıkarın  
- 📄 **Detaylı Profil:** Kullanıcı hakkında kapsamlı bilgi görüntüleyin  
- 🎨 **Modern Tasarım:** SwiftUI ile geliştirilmiş sade ve modern arayüz

### 🚀 Teknik Özellikler

- ⚡ **Eşzamansız Veri Yükleme:** Combine ile performanslı API çağrıları  
- 💾 **Lokal Veri Saklama:** UserDefaults ile favorilerin kalıcı olarak saklanması  
- 🔄 **Otomatik Yenileme:** Pull-to-refresh ile kolay veri güncelleme  
- 📐 **Responsive Design:** Tüm iOS cihazlarında uyumlu arayüz  
- 👋 **Onboarding:** İlk kullanımda etkileşimli tanıtım ekranları

---

### 🏠 İstenilen Sayfalar
- **Kullanıcılar Sekmesi:** Tüm kullanıcıları listeleme ve arama
- **Favoriler Sekmesi:** Favoriye eklenmiş kullanıcıları listeleme
- **Kullanıcı Detayı:** Profil, iletişim, adres ve şirket bilgileri

### 📋 Özel Sayfalar
- **Onboarding:** 3 sayfalı interaktif tanıtım ekranı
- **Ayarlar Sekmesi:** Uygulama ayarları ve bilgi sayfası
- **LaunchScreen:** Uygulama başlarken uygulama adı ve logosunun gözüktüğü ekran
---

## 🔧 Kullanım

Uygulamayı indirip çalıştırdıktan sonra aşağıdaki adımları izleyerek tüm özellikleri kolayca kullanabilirsiniz:

### 🚀 İlk Çalıştırma

- Uygulama ilk açıldığında **3 adımlı onboarding ekranı** sizi karşılar  
- Tanıtım ekranlarını geçmek için "Başla" butonuna tıklayın  
- Ana sekmeli kullanıcı arayüzüne yönlendirilirsiniz

### 👥 Kullanıcıları Görüntüleme

1. **"Kullanıcılar"** sekmesine gidin  
2. JSONPlaceholder API'den yüklenen kullanıcı listesini görüntüleyin  
3. Arama çubuğunu kullanarak **isim, e-posta veya kullanıcı adına göre** filtreleme yapın  
4. Listeyi yenilemek için ekranı aşağı çekerek **pull-to-refresh** kullanın

### ❤️ Favori Ekleme / Çıkarma

- Kullanıcı kartının sağ üst köşesindeki **kalp ikonuna** tıklayarak favori ekleyin veya kaldırın  
- Detay sayfasında da "Favorilere Ekle/Çıkar" işlemi yapılabilir  
- Tüm favori kullanıcıları **"Favoriler"** sekmesinde görüntüleyebilirsiniz

### 📄 Kullanıcı Detaylarını Görüntüleme

1. Kullanıcı listesinden herhangi bir kullanıcıya dokunun  
2. Açılan detay sayfasında şu bilgileri görebilirsiniz:
   - Profil fotoğrafı
   - İsim ve kullanıcı adı
   - E-posta, telefon ve web sitesi
   - Adres bilgileri (şehir, sokak, posta kodu)
   - Şirket adı ve sloganı

### ⚙️ Ayarlar Sekmesi

- "Ayarlar" sekmesinden uygulama hakkında bilgiler bulunur  
- Bu sekmede favorilerinizi yönetebilirsiniz


---

## 🛠 Teknoloji Stack'i

### 🧩 Framework & Dil
- SwiftUI – Modern UI geliştirme
- Swift – iOS uygulama dili
- Combine – Reactive programming desteği

### 🔗 Veri Yönetimi
- URLSession – API çağrıları
- UserDefaults – Lokal veri saklama
- Codable – JSON verisini parse etme

### 🌐 Dış Kaynaklar
- [JSONPlaceholder](https://jsonplaceholder.typicode.com) – Kullanıcı verisi kaynağı
- [Picsum Photos](https://picsum.photos/) – Rastgele profil fotoğrafları

---

## 🎨 Tasarım Prensipleri

Modernist User App, okunabilir ve sürdürülebilir kod mimarisi ile geliştirilmiştir:

### 🧱 MVVM (Model-View-ViewModel) Mimarisi

- **Model:** Kullanıcı veri yapıları (`User`)
- **View:** SwiftUI ile oluşturulmuş kullanıcı arayüz bileşenleri
- **ViewModel:** İş mantığı ve veri yönetimi Combine ile `@Published` ve `ObservableObject` kullanılarak gerçekleştirilmiştir

### 🔁 Singleton Pattern

- `APIService`: API işlemleri için tekil servis
- `FavoritesService`: Favori kullanıcı yönetimi için merkezi servis

### ⚙️ Reactive Programming (Combine)

- `@Published`: Değişikliklerin otomatik olarak UI'a yansıması
- `ObservableObject`: ViewModel'lerin izlenmesi
- Combine abonelikleri ile API verilerinin akıcı biçimde yönetilmesi

---

## 📋 Sistem Gereksinimleri

- **iOS:** 14.0+
- **Xcode:** 12.0+
- **Swift:** 5.3+
- **İnternet Bağlantısı:** API verilerini alabilmek için gereklidir

---

## 🚀 Kurulum

1. 📦 **Projeyi İndirin**
```bash
git clone https://github.com/berkayemre/ModernistUserApp.git
cd ModernistUserApp
open ModernistUserApp.xcodeproj

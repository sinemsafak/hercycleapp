# HERCYCLE AI ♻️

**AI-Powered Circular Fashion & Women Entrepreneurship Ecosystem**

HERCYCLE AI, tekstil atıklarını yeniden değerlendirmeyi ve kadın girişimcilerin daha sürdürülebilir, veri odaklı üretim kararları almasını desteklemeyi amaçlayan yapay zekâ tabanlı bir mobil uygulama projesidir.

Proje; **yapay zekâ, döngüsel moda, sürdürülebilir üretim ve kadın girişimciliğini** tek bir dijital ekosistemde bir araya getirir.

---

## 🎯 Problem

Moda sektöründe;

* İhtiyaç fazlası üretim,
* Tekstil atıkları ve ölü stoklar,
* Talebin doğru tahmin edilememesi,
* Küçük girişimcilerin veri ve teknolojiye sınırlı erişimi,
* Kadın girişimcilerin ekonomik ve psikolojik bariyerlerle karşılaşması

önemli problemler arasında yer almaktadır.

HERCYCLE AI, bu problemlere teknoloji destekli ve döngüsel bir yaklaşım sunmayı hedefler.

---

## 💡 Çözüm

HERCYCLE AI ile kullanıcılar ellerindeki kumaş veya tekstil materyallerini sisteme tanımlayabilir.

Yapay zekâ ve kural tabanlı öneri sistemi kullanılarak materyalin özelliklerine göre yeniden üretilebilecek ürün alternatifleri oluşturulur.

Sistem aynı zamanda moda verilerinden yararlanarak trend ve ürün önerileri sunmayı hedefler.

Örnek:

**Girdi**

> Denim kumaş / tekstil firesi

**AI Analizi**

> Material: Denim
> Color: Blue
> Pattern: Solid

**Öneriler**

> Tote Bag
> Patchwork Skirt
> Denim Accessory

---

## 🚀 Temel Özellikler

### 🧵 AI Destekli Kumaş ve Moda Analizi

Computer Vision modelleri kullanılarak kıyafet ve tekstil görsellerinden;

* materyal,
* renk,
* desen,
* kategori,
* stil

gibi özelliklerin belirlenmesi hedeflenmektedir.

### 📈 Trend ve Üretim Önerileri

Moda datasetlerinden elde edilen veriler kullanılarak ürün kategorileri ve trendler analiz edilir.

Amaç, girişimcilere **“Ne üretmeliyim?”** ve **“Hangi ürün daha yüksek potansiyele sahip?”** sorularında veri destekli öneriler sunmaktır.

### ♻️ Upcycling Recommendation Engine

Tekstil atıkları için yeterli ve uygun açık veri bulunmadığı durumlarda sistem, **AI + kural tabanlı hibrit bir yaklaşım** kullanır.

Örneğin:

`Denim + Büyük Kumaş Parçası → Tote Bag / Etek / Patchwork Ceket`

Bu kurallar sürdürülebilir moda ve ileri dönüşüm araştırmaları doğrultusunda oluşturulur.

### 🌱 Sürdürülebilirlik Etkisi

Uygulama, yeniden değerlendirilen tekstil materyallerinin etkisini kullanıcıya anlaşılır şekilde göstermeyi hedefler.

Örneğin:

> ♻️ 2.4 kg tekstil atığı yeniden değerlendirildi.

Amaç, korku temelli iklim iletişimi yerine **ölçülebilir ve pozitif etkiyi** görünür kılmaktır.

### 💬 Kadın Girişimci Destek Asistanı

HERCYCLE AI içerisinde kadın girişimcilere yönelik destekleyici bir sohbet asistanı planlanmaktadır.

Asistan;

* motivasyon,
* girişimcilik stresi,
* hedef belirleme,
* psikolojik dayanıklılık,
* sürdürülebilir üretim

konularında destekleyici konuşmalar sunar.

> **Not:** Bu özellik profesyonel psikolojik tedavi veya teşhis amacı taşımaz. Destekleyici bir wellbeing ve girişimcilik asistanı olarak tasarlanmıştır.

---

## 🧠 AI & Veri Yapısı

Projede farklı amaçlara yönelik açık veri kaynaklarından yararlanılmaktadır.

### Fashion Product Images

Moda ürünlerinin kategori, renk ve ürün özelliklerinin analizinde kullanılmaktadır.

### Clothing Dataset

Kıyafet görsellerinin sınıflandırılması ve Computer Vision modelinin geliştirilmesinde kullanılmaktadır.

### iMaterialist / Marqo

Kıyafet görsellerinden;

* material,
* pattern,
* color,
* style,
* category

gibi moda özelliklerinin analiz edilmesinde kullanılmaktadır.

### Mental Health in Tech Survey

Psikolojik dayanıklılık ve çalışanların mental wellbeing problemlerinin araştırılması için referans veri kaynaklarından biri olarak değerlendirilmektedir.

---

## 🏗️ Sistem Mimarisi

```text
                HERCYCLE AI
                     │
              Flutter Mobile App
                     │
             ┌───────┴───────┐
             │               │
        AI Analysis       AI Chatbot
             │               │
          Backend API ────────┘
             │
     ┌───────┴────────┐
     │                │
Computer Vision   Rule Engine
     │                │
Fashion Analysis  Upcycling
                  Recommendations
```

---

## 🛠️ Teknolojiler

**Mobile**

* Flutter
* Dart

**AI / Machine Learning**

* Python
* TensorFlow / PyTorch
* MobileNet
* Google Colab

**Backend**

* FastAPI
* REST API

**Database & Services**

* Firebase

**UI/UX**

* Figma

---

## 📱 Uygulama Akışı

```text
Kullanıcı
   ↓
Kumaş / Ürün Görseli Yükler
   ↓
AI Görsel Analizi
   ↓
Materyal + Renk + Desen + Kategori
   ↓
Trend Analizi
   ↓
Upcycling Rule Engine
   ↓
Sürdürülebilir Ürün Önerileri
   ↓
Etki Sonuçları
```

Kullanıcı ayrıca uygulama içerisindeki AI destek asistanı üzerinden girişimcilik ve wellbeing konularında destek alabilir.

---

## 🎯 Projenin Hedefleri

HERCYCLE AI ile;

* tekstil atıklarının yeniden değerlendirilmesi,
* aşırı üretimin azaltılması,
* sürdürülebilir moda kültürünün yaygınlaştırılması,
* kadın girişimcilerin teknolojiye erişiminin artırılması,
* veri odaklı üretim kararlarının desteklenmesi,
* kadın girişimcilerin ekonomik ve psikolojik dayanıklılığının güçlendirilmesi

hedeflenmektedir.

---

## 🌍 Vizyon

HERCYCLE AI'ın uzun vadeli vizyonu, tekstil atıklarının yalnızca çevresel bir problem olarak değil, **kadın girişimciler için yeni bir ekonomik üretim kaynağı** olarak değerlendirildiği döngüsel bir moda ekosistemi oluşturmaktır.

**Waste → Data → Design → Women Entrepreneurship → Impact**

---

## 👥 Team

HERCYCLE AI, yazılım geliştirme, yapay zekâ, UI/UX, sürdürülebilirlik, kadın girişimciliği ve sosyal etki alanlarında çalışan multidisipliner bir ekip tarafından geliştirilmektedir.

---

## 📌 Project Status

🚧 **Prototype / MVP Development**

Proje aktif olarak geliştirilmektedir.

---

## 📄 License

Projenin kaynak kodu ve kullanılan açık veri setlerinin lisansları ayrı ayrı değerlendirilmelidir. Kullanılan datasetlerin orijinal lisans koşulları geçerlidir.

---

**HERCYCLE AI**
*Turning textile waste into opportunity.* ♻️

from fastapi import FastAPI, UploadFile, File
from fastapi.middleware.cors import CORSMiddleware

import tensorflow as tf
import numpy as np
from PIL import Image
import json
import io

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# MODEL YÜKLE
model = tf.keras.models.load_model(
    "hercycle_material_model.keras"
)

# LABELS YÜKLE
with open("labels.json", "r") as f:
    labels = json.load(f)

# ÜRÜN ÖNERİLERİ
recommendations = {
    "Polyester": [
        "Tote Bag",
        "Mini Backpack",
        "Accessory Pouch"
    ],
    "Chiffon": [
        "Scarf",
        "Summer Blouse",
        "Kimono"
    ],
    "Spandex": [
        "Sports Bag",
        "Gym Accessory",
        "Headband"
    ],
    "Polyester Spandex": [
        "Patchwork Jacket",
        "Mini Skirt",
        "Fashion Bag"
    ]
}


@app.get("/")
def root():
    return {
        "message": "HERCYCLE AI Backend Running"
    }


@app.post("/predict")
async def predict(
    file: UploadFile = File(...)
):

    image_bytes = await file.read()

    image = Image.open(
        io.BytesIO(image_bytes)
    ).convert("RGB")

    image = image.resize((224, 224))

    img_array = np.array(image)

    img_array = tf.keras.applications.mobilenet_v2.preprocess_input(
        img_array
    )

    img_array = np.expand_dims(
        img_array,
        axis=0
    )

    prediction = model.predict(
        img_array,
        verbose=0
    )

    predicted_index = int(
        np.argmax(prediction)
    )

    confidence = float(
        np.max(prediction)
    )

    material = labels[
        predicted_index
    ]

    return {
        "material": material,
        "confidence": round(
            confidence,
            3
        ),
        "trend_score": 87,
        "recommended_products":
        recommendations.get(
            material,
            []
        )
    }
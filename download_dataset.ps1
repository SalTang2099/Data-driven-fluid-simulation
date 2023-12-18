param(
    [string]$DATASET_NAME,
    [string]$OUTPUT_DIR
)

$BASE_URL = "https://storage.googleapis.com/learning-to-simulate-complex-physics/Datasets/$DATASET_NAME/"

$OUTPUT_DIR = Join-Path $OUTPUT_DIR $DATASET_NAME

if (-not (Test-Path -Path $OUTPUT_DIR)) {
    New-Item -ItemType Directory -Force -Path $OUTPUT_DIR
}

$files = "metadata.json", "train.tfrecord", "valid.tfrecord", "test.tfrecord"

foreach ($file in $files) {
    $url = $BASE_URL + $file
    $outputFilePath = Join-Path $OUTPUT_DIR $file
    Invoke-WebRequest -Uri $url -OutFile $outputFilePath
}

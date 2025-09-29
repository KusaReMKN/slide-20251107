TARGET=slide.mp4

all: $(TARGET)

slide.pdf: slide.tex
	latexmk -lualatex slide

frames: slide.pdf
	mkdir -p frames
	pdftoppm -png -r 600 slide.pdf frames/frame

videos/slide01-14.mp4: frames
	ffmpeg -y \
		-start_number 1 \
		-framerate 1 \
		-i frames/frame-%02d.png \
		-f lavfi -t 14 -i anullsrc=channel_layout=stereo:sample_rate=44100 \
		-c:a aac \
		-shortest \
		-c:v hevc_nvenc \
		-profile:v 0 \
		-pix_fmt yuv420p \
		-s 1920x1080 \
		-r 30 \
		-movflags +faststart \
		videos/slide01-14.mp4

videos/slide15-15.mp4: frames
	ffmpeg -y \
		-start_number 15 \
		-framerate 1 \
		-i frames/frame-%02d.png \
		-f lavfi -t 1 -i anullsrc=channel_layout=stereo:sample_rate=44100 \
		-c:a aac \
		-shortest \
		-c:v hevc_nvenc \
		-profile:v 0 \
		-pix_fmt yuv420p \
		-s 1920x1080 \
		-r 30 \
		-movflags +faststart \
		videos/slide15-15.mp4

videos/slide16-16.mp4: frames
	ffmpeg -y \
		-start_number 16 \
		-framerate 1 \
		-i frames/frame-%02d.png \
		-f lavfi -t 1 -i anullsrc=channel_layout=stereo:sample_rate=44100 \
		-c:a aac \
		-shortest \
		-c:v hevc_nvenc \
		-profile:v 0 \
		-pix_fmt yuv420p \
		-s 1920x1080 \
		-r 30 \
		-movflags +faststart \
		videos/slide16-16.mp4

videos/slide17-24.mp4: frames
	ffmpeg -y \
		-start_number 17 \
		-framerate 1 \
		-i frames/frame-%02d.png \
		-f lavfi -t 8 -i anullsrc=channel_layout=stereo:sample_rate=44100 \
		-c:a aac \
		-shortest \
		-c:v hevc_nvenc \
		-profile:v 0 \
		-pix_fmt yuv420p \
		-s 1920x1080 \
		-r 30 \
		-movflags +faststart \
		videos/slide17-24.mp4

videos/slide25-25.mp4: frames
	ffmpeg -y \
		-start_number 25 \
		-framerate 1 \
		-i frames/frame-%02d.png \
		-f lavfi -t 1 -i anullsrc=channel_layout=stereo:sample_rate=44100 \
		-c:a aac \
		-shortest \
		-c:v hevc_nvenc \
		-profile:v 0 \
		-pix_fmt yuv420p \
		-s 1920x1080 \
		-r 30 \
		-movflags +faststart \
		videos/slide25-25.mp4

videos/slide26-XX.mp4: frames
	ffmpeg -y \
		-start_number 26 \
		-framerate 1 \
		-i frames/frame-%02d.png \
		-f lavfi -t 12 -i anullsrc=channel_layout=stereo:sample_rate=44100 \
		-c:a aac \
		-shortest \
		-c:v hevc_nvenc \
		-profile:v 0 \
		-pix_fmt yuv420p \
		-s 1920x1080 \
		-r 30 \
		-movflags +faststart \
		videos/slide26-XX.mp4

slide.mp4: videos/slide01-14.mp4 videos/addition.mp4 \
		videos/slide15-15.mp4 videos/subtraction.mp4 \
		videos/slide16-16.mp4 videos/negative.mp4 \
		videos/slide17-24.mp4 videos/multiplication.mp4 \
		videos/slide25-25.mp4 videos/division.mp4 \
		videos/slide26-XX.mp4 videos/blooper.mp4
	touch slide.mp4

.PHONY: clean
clean:
	latexmk -C
	rm -rf frames
	rm -f videos/slide*.mp4
	rm -f slide.mp4

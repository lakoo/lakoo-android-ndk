FROM openjdk:8u121-jdk
MAINTAINER William Chong <williamchong@lakoo.com>

RUN mkdir -p /opt
WORKDIR /opt

ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools:${PATH}:${ANDROID_HOME}/tools
ENV ANDROID_NDK /opt/android-ndk-linux
ENV ANDROID_NDK_HOME /opt/android-ndk-linux

RUN apt-get install -y --no-install-recommends \
	wget
RUN wget -q --output-document=android-sdk.tgz https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz && \
	tar --no-same-owner -xzf android-sdk.tgz && \
	rm -f android-sdk.tgz && \
	echo y | android update sdk -u -a -t platform-tools && \
	echo y | android update sdk -u -a -t build-tools-25.0.3,android-25 && \
	echo y | android update sdk -u -a -t extra-android-m2repository,extra-google-m2repository,extra-google-google_play_services
RUN wget -q --output-document=android-ndk.zip https://dl.google.com/android/repository/android-ndk-r14b-linux-x86_64.zip && \
	unzip android-ndk.zip && \
	rm -f android-ndk.zip && \
	mv android-ndk-r14b android-ndk-linux

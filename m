Content-Type: multipart/mixed; boundary="===============7617252193929916864=="
MIME-Version: 1.0
From: Sinthu Raja M <sinthu.raja@mistralsolutions.com>
Subject: HFP no audio
Date: Tue, 07 Mar 2017 23:02:50 +0530
Message-ID: <CAEd-yTSgCAzxkyXYLwiqTzADmXR1ekAD8QxM5mjt=JKuQVCLiA@mail.gmail.com>
In-Reply-To: <CAEd-yTQ5vN8wwo8y80uAwQ3sgBrG2CXwLWPiZD0mksB9LZ6SdA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7617252193929916864==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

I am currently working in Bluez5.43+Ofono+Pulseaduio9 to make HFP works.

My target device doesn't have a microphone only a speaker.

I am running the following daemons.
bluetoothd
ofonod
pulseaudio

Then I tried connecting to the mobile phone, it got connected. when I
tried playing music from my mobile phone I got the sound from my
target device.

When I tried calling to my mobile from another mobile I didn't get the
sound. I got the following errors

I: [alsa-sink-i2s0-sec HiFi-0] module-loopback.c: Could not peek into queue
I: [alsa-sink-i2s0-sec HiFi-0] module-loopback.c: Could not peek into queue
I: [alsa-sink-i2s0-sec HiFi-0] module-loopback.c: Could not peek into queue
I: [alsa-sink-i2s0-sec HiFi-0] module-loopback.c: Could not peek into queue
I: [alsa-sink-i2s0-sec HiFi-0] module-loopback.c: Could not peek into queue
I: [alsa-sink-i2s0-sec HiFi-0] module-loopback.c: Could not peek into queue
D: [pulseaudio] module-loopback.c: Loopback overall latency is 25.57
ms + 0.00 ms + 25.00 ms =3D 50.58 ms
D: [pulseaudio] module-loopback.c: Should buffer 2752 bytes, buffered
at minimum 0 bytes
I: [pulseaudio] module-loopback.c: New rate of 7863 Hz not within 2=E2=80=
=B0
of 8000 Hz, forcing smaller adjustment
D: [pulseaudio] module-loopback.c:
[alsa_output.platform-sound.13.analog-stereo] Updated sampling rate to
7984 Hz.
D: [pulseaudio] module-loopback.c: Loopback overall latency is 23.20
ms + 0.00 ms + 25.00 ms =3D 48.20 ms
D: [pulseaudio] module-loopback.c: Should buffer 2752 bytes, buffered
at minimum 0 bytes
I: [pulseaudio] module-loopback.c: New rate of 7863 Hz not within 2=E2=80=
=B0
of 8000 Hz, forcing smaller adjustment
D: [pulseaudio] module-loopback.c:
[alsa_output.platform-sound.13.analog-stereo] Updated sampling rate to
7984 Hz.
D: [pulseaudio] module-loopback.c: Loopback overall latency is 34.00
ms + 10490.00 ms + 0.00 ms =3D 10524.00 ms
D: [pulseaudio] module-loopback.c: Should buffer 96 bytes, buffered at
minimum 1366 bytes
I: [pulseaudio] module-loopback.c: New rate of 8063 Hz not within 2=E2=80=
=B0
of 8000 Hz, forcing smaller adjustment
D: [pulseaudio] module-loopback.c: [bluez_sink.80_01_84_1C_1F_EA]
Updated sampling rate to 8016 Hz.
D: [alsa-sink-i2s0-sec HiFi-0] ratelimit.c: 51 events suppressed
D: [alsa-sink-i2s0-sec HiFi-0] alsa-sink.c: Wakeup from ALSA!
I: [alsa-sink-i2s0-sec HiFi-0] module-loopback.c: Could not peek into queue
I: [alsa-sink-i2s0-sec HiFi-0] module-loopback.c: Could not peek into queue
I: [alsa-sink-i2s0-sec HiFi-0] module-loopback.c: Could not peek into queue
I: [alsa-sink-i2s0-sec HiFi-0] module-loopback.c: Could not peek into queue
D: [alsa-sink-i2s0-sec HiFi-0] alsa-sink.c: Wakeup from ALSA!



When I tried pacmd list-sinks I got the following output

index: 0
        name: <alsa_output.platform-sound.13.analog-stereo>
        driver: <module-alsa-card.c>
        flags: HARDWARE DECIBEL_VOLUME LATENCY FLAT_VOLUME DYNAMIC_LATENCY
        state: IDLE
        suspend cause:
        priority: 9009
        volume: front-left: 65536 / 100% / 0.00 dB,   front-right:
65536 / 100% / 0.00 dB
                balance 0.00
        base volume: 65536 / 100% / 0.00 dB
        volume steps: 65537
        muted: no
        current latency: 53.56 ms
        max request: 16 KiB
        max rewind: 32 KiB
        monitor source: 0
        sample spec: s16le 2ch 48000Hz
        channel map: front-left,front-right
                     Stereo
        used by: 0
        linked by: 3
        configured latency: 86.00 ms; range is 86.00 .. 170.67 ms
        card: 0 <alsa_card.platform-sound.13>
        module: 6
        properties:
                alsa.resolution_bits =3D "16"
                device.api =3D "alsa"
                device.class =3D "sound"
                alsa.class =3D "generic"
                alsa.subclass =3D "generic-mix"
                alsa.name =3D ""
                alsa.id =3D "i2s0-sec HiFi-0"
                alsa.subdevice =3D "0"
                alsa.subdevice_name =3D "subdevice #0"
                alsa.device =3D "0"
                alsa.card =3D "0"
                alsa.card_name =3D "xxx-audio"
                alsa.long_card_name =3D "xxx-audio"
                device.bus_path =3D "platform-sound.13"
                sysfs.path =3D "/devices/sound.13/sound/card0"
                device.string =3D "hw:0"
                device.buffering.buffer_size =3D "32768"
                device.buffering.fragment_size =3D "16384"
                device.access_mode =3D "mmap+timer"
                device.profile.name =3D "analog-stereo"
                device.profile.description =3D "Analog Stereo"
                device.description =3D "audio Analog Stereo"
                module-udev-detect.discovered =3D "1"
                device.icon_name =3D "audio-card"
        ports:
                analog-output: Analog Output (priority 9900, latency
offset 0 usec, available: unknown)
                        properties:

        active port: <analog-output>
    index: 1
        name: <bluez_sink.80_01_84_1C_1F_EA>
        driver: <module-bluez5-device.c>
        flags: HARDWARE DECIBEL_VOLUME LATENCY FLAT_VOLUME
        state: SUSPENDED
        suspend cause: USER
        priority: 9030
        volume: mono: 65536 / 100% / 0.00 dB
                balance 0.00
        base volume: 65536 / 100% / 0.00 dB
        volume steps: 65537
        muted: no
        current latency: 0.00 ms
        max request: 0 KiB
        max rewind: 0 KiB
        monitor source: 1
        sample spec: s16le 1ch 8000Hz
        channel map: mono
                     Mono
        used by: 1
        linked by: 1
        fixed latency: 128.00 ms
        card: 1 <bluez_card.80_01_84_1C_1F_EA>
        module: 22
        properties:
                bluetooth.protocol =3D "headset_audio_gateway"
                device.description =3D "Raja rashid"
                device.string =3D "80:01:84:1C:1F:EA"
                device.api =3D "bluez"
                device.class =3D "sound"
                device.bus =3D "bluetooth"
                device.form_factor =3D "phone"
                bluez.path =3D "/org/bluez/hci0/dev_80_01_84_1C_1F_EA"
                bluez.class =3D "0x5a020c"
                bluez.alias =3D "Raja rashid"
                device.icon_name =3D "audio-card-bluetooth"
        ports:
                phone-output: Phone (priority 0, latency offset 0
usec, available: yes)
                        properties:

        active port: <phone-output>

What could be the possible reasons for the sound is not coming only
when HFP is active. Is there any extra configurations I have to add.
Please suggest.
Thanks in advance

With Regards

Sinthu Raja



-- =

With Regards

Sinthu Raja

--===============7617252193929916864==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGJyPjxicj5IaSBhbGwsPGJyPgo8YnI+CkkgYW0gY3VycmVudGx5IHdvcmtpbmcgaW4gQmx1ZXo1
LjQzK09mb25vK1B1bHNlYWR1aW85IHRvIG1ha2UgSEZQIHdvcmtzLjxicj4KPGJyPgpNeSB0YXJn
ZXQgZGV2aWNlIGRvZXNuJiMzOTt0IGhhdmUgYSBtaWNyb3Bob25lIG9ubHkgYSBzcGVha2VyLjxi
cj4KPGJyPgpJIGFtIHJ1bm5pbmcgdGhlIGZvbGxvd2luZyBkYWVtb25zLjxicj4KYmx1ZXRvb3Ro
ZDxicj4Kb2Zvbm9kPGJyPgpwdWxzZWF1ZGlvPGJyPgo8YnI+ClRoZW4gSSB0cmllZCBjb25uZWN0
aW5nIHRvIHRoZSBtb2JpbGUgcGhvbmUsIGl0IGdvdCBjb25uZWN0ZWQuIHdoZW4gSTxicj4KdHJp
ZWQgcGxheWluZyBtdXNpYyBmcm9tIG15IG1vYmlsZSBwaG9uZSBJIGdvdCB0aGUgc291bmQgZnJv
bSBteTxicj4KdGFyZ2V0IGRldmljZS48YnI+Cjxicj4KV2hlbiBJIHRyaWVkIGNhbGxpbmcgdG8g
bXkgbW9iaWxlIGZyb20gYW5vdGhlciBtb2JpbGUgSSBkaWRuJiMzOTt0IGdldCB0aGU8YnI+CnNv
dW5kLiBJIGdvdCB0aGUgZm9sbG93aW5nIGVycm9yczxicj4KPGJyPgpJOiBbYWxzYS1zaW5rLWky
czAtc2VjIEhpRmktMF0gbW9kdWxlLWxvb3BiYWNrLmM6IENvdWxkIG5vdCBwZWVrIGludG8gcXVl
dWU8YnI+Ckk6IFthbHNhLXNpbmstaTJzMC1zZWMgSGlGaS0wXSBtb2R1bGUtbG9vcGJhY2suYzog
Q291bGQgbm90IHBlZWsgaW50byBxdWV1ZTxicj4KSTogW2Fsc2Etc2luay1pMnMwLXNlYyBIaUZp
LTBdIG1vZHVsZS1sb29wYmFjay5jOiBDb3VsZCBub3QgcGVlayBpbnRvIHF1ZXVlPGJyPgpJOiBb
YWxzYS1zaW5rLWkyczAtc2VjIEhpRmktMF0gbW9kdWxlLWxvb3BiYWNrLmM6IENvdWxkIG5vdCBw
ZWVrIGludG8gcXVldWU8YnI+Ckk6IFthbHNhLXNpbmstaTJzMC1zZWMgSGlGaS0wXSBtb2R1bGUt
bG9vcGJhY2suYzogQ291bGQgbm90IHBlZWsgaW50byBxdWV1ZTxicj4KSTogW2Fsc2Etc2luay1p
MnMwLXNlYyBIaUZpLTBdIG1vZHVsZS1sb29wYmFjay5jOiBDb3VsZCBub3QgcGVlayBpbnRvIHF1
ZXVlPGJyPgpEOiBbcHVsc2VhdWRpb10gbW9kdWxlLWxvb3BiYWNrLmM6IExvb3BiYWNrIG92ZXJh
bGwgbGF0ZW5jeSBpcyAyNS41Nzxicj4KbXMgKyAwLjAwIG1zICsgMjUuMDAgbXMgPSA1MC41OCBt
czxicj4KRDogW3B1bHNlYXVkaW9dIG1vZHVsZS1sb29wYmFjay5jOiBTaG91bGQgYnVmZmVyIDI3
NTIgYnl0ZXMsIGJ1ZmZlcmVkPGJyPgphdCBtaW5pbXVtIDAgYnl0ZXM8YnI+Ckk6IFtwdWxzZWF1
ZGlvXSBtb2R1bGUtbG9vcGJhY2suYzogTmV3IHJhdGUgb2YgNzg2MyBIeiBub3Qgd2l0aGluIDLi
gLA8YnI+Cm9mIDgwMDAgSHosIGZvcmNpbmcgc21hbGxlciBhZGp1c3RtZW50PGJyPgpEOiBbcHVs
c2VhdWRpb10gbW9kdWxlLWxvb3BiYWNrLmM6PGJyPgpbYWxzYV9vdXRwdXQucGxhdGZvcm0tc291
bmQuPHdicj4xMy5hbmFsb2ctc3RlcmVvXSBVcGRhdGVkIHNhbXBsaW5nIHJhdGUgdG88YnI+Cjc5
ODQgSHouPGJyPgpEOiBbcHVsc2VhdWRpb10gbW9kdWxlLWxvb3BiYWNrLmM6IExvb3BiYWNrIG92
ZXJhbGwgbGF0ZW5jeSBpcyAyMy4yMDxicj4KbXMgKyAwLjAwIG1zICsgMjUuMDAgbXMgPSA0OC4y
MCBtczxicj4KRDogW3B1bHNlYXVkaW9dIG1vZHVsZS1sb29wYmFjay5jOiBTaG91bGQgYnVmZmVy
IDI3NTIgYnl0ZXMsIGJ1ZmZlcmVkPGJyPgphdCBtaW5pbXVtIDAgYnl0ZXM8YnI+Ckk6IFtwdWxz
ZWF1ZGlvXSBtb2R1bGUtbG9vcGJhY2suYzogTmV3IHJhdGUgb2YgNzg2MyBIeiBub3Qgd2l0aGlu
IDLigLA8YnI+Cm9mIDgwMDAgSHosIGZvcmNpbmcgc21hbGxlciBhZGp1c3RtZW50PGJyPgpEOiBb
cHVsc2VhdWRpb10gbW9kdWxlLWxvb3BiYWNrLmM6PGJyPgpbYWxzYV9vdXRwdXQucGxhdGZvcm0t
c291bmQuPHdicj4xMy5hbmFsb2ctc3RlcmVvXSBVcGRhdGVkIHNhbXBsaW5nIHJhdGUgdG88YnI+
Cjc5ODQgSHouPGJyPgpEOiBbcHVsc2VhdWRpb10gbW9kdWxlLWxvb3BiYWNrLmM6IExvb3BiYWNr
IG92ZXJhbGwgbGF0ZW5jeSBpcyAzNC4wMDxicj4KbXMgKyAxMDQ5MC4wMCBtcyArIDAuMDAgbXMg
PSAxMDUyNC4wMCBtczxicj4KRDogW3B1bHNlYXVkaW9dIG1vZHVsZS1sb29wYmFjay5jOiBTaG91
bGQgYnVmZmVyIDk2IGJ5dGVzLCBidWZmZXJlZCBhdDxicj4KbWluaW11bSAxMzY2IGJ5dGVzPGJy
PgpJOiBbcHVsc2VhdWRpb10gbW9kdWxlLWxvb3BiYWNrLmM6IE5ldyByYXRlIG9mIDgwNjMgSHog
bm90IHdpdGhpbiAy4oCwPGJyPgpvZiA4MDAwIEh6LCBmb3JjaW5nIHNtYWxsZXIgYWRqdXN0bWVu
dDxicj4KRDogW3B1bHNlYXVkaW9dIG1vZHVsZS1sb29wYmFjay5jOiBbYmx1ZXpfc2luay44MF8w
MV84NF8xQ18xRl9FQV08YnI+ClVwZGF0ZWQgc2FtcGxpbmcgcmF0ZSB0byA4MDE2IEh6Ljxicj4K
RDogW2Fsc2Etc2luay1pMnMwLXNlYyBIaUZpLTBdIHJhdGVsaW1pdC5jOiA1MSBldmVudHMgc3Vw
cHJlc3NlZDxicj4KRDogW2Fsc2Etc2luay1pMnMwLXNlYyBIaUZpLTBdIGFsc2Etc2luay5jOiBX
YWtldXAgZnJvbSBBTFNBITxicj4KSTogW2Fsc2Etc2luay1pMnMwLXNlYyBIaUZpLTBdIG1vZHVs
ZS1sb29wYmFjay5jOiBDb3VsZCBub3QgcGVlayBpbnRvIHF1ZXVlPGJyPgpJOiBbYWxzYS1zaW5r
LWkyczAtc2VjIEhpRmktMF0gbW9kdWxlLWxvb3BiYWNrLmM6IENvdWxkIG5vdCBwZWVrIGludG8g
cXVldWU8YnI+Ckk6IFthbHNhLXNpbmstaTJzMC1zZWMgSGlGaS0wXSBtb2R1bGUtbG9vcGJhY2su
YzogQ291bGQgbm90IHBlZWsgaW50byBxdWV1ZTxicj4KSTogW2Fsc2Etc2luay1pMnMwLXNlYyBI
aUZpLTBdIG1vZHVsZS1sb29wYmFjay5jOiBDb3VsZCBub3QgcGVlayBpbnRvIHF1ZXVlPGJyPgpE
OiBbYWxzYS1zaW5rLWkyczAtc2VjIEhpRmktMF0gYWxzYS1zaW5rLmM6IFdha2V1cCBmcm9tIEFM
U0EhPGJyPgo8YnI+Cjxicj4KPGJyPgpXaGVuIEkgdHJpZWQgcGFjbWQgbGlzdC1zaW5rcyBJIGdv
dCB0aGUgZm9sbG93aW5nIG91dHB1dDxicj4KPGJyPgppbmRleDogMDxicj4KwqAgwqAgwqAgwqAg
bmFtZTogJmx0O2Fsc2Ffb3V0cHV0LnBsYXRmb3JtLXNvdW5kLjx3YnI+MTMuYW5hbG9nLXN0ZXJl
byZndDs8YnI+CsKgIMKgIMKgIMKgIGRyaXZlcjogJmx0O21vZHVsZS1hbHNhLWNhcmQuYyZndDs8
YnI+CsKgIMKgIMKgIMKgIGZsYWdzOiBIQVJEV0FSRSBERUNJQkVMX1ZPTFVNRSBMQVRFTkNZIEZM
QVRfVk9MVU1FIERZTkFNSUNfTEFURU5DWTxicj4KwqAgwqAgwqAgwqAgc3RhdGU6IElETEU8YnI+
CsKgIMKgIMKgIMKgIHN1c3BlbmQgY2F1c2U6PGJyPgrCoCDCoCDCoCDCoCBwcmlvcml0eTogOTAw
OTxicj4KwqAgwqAgwqAgwqAgdm9sdW1lOiBmcm9udC1sZWZ0OiA2NTUzNiAvIDEwMCUgLyAwLjAw
IGRCLMKgIMKgZnJvbnQtcmlnaHQ6PGJyPgo2NTUzNiAvIDEwMCUgLyAwLjAwIGRCPGJyPgrCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBiYWxhbmNlIDAuMDA8YnI+CsKgIMKgIMKgIMKgIGJhc2Ugdm9s
dW1lOiA2NTUzNiAvIDEwMCUgLyAwLjAwIGRCPGJyPgrCoCDCoCDCoCDCoCB2b2x1bWUgc3RlcHM6
IDY1NTM3PGJyPgrCoCDCoCDCoCDCoCBtdXRlZDogbm88YnI+CsKgIMKgIMKgIMKgIGN1cnJlbnQg
bGF0ZW5jeTogNTMuNTYgbXM8YnI+CsKgIMKgIMKgIMKgIG1heCByZXF1ZXN0OiAxNiBLaUI8YnI+
CsKgIMKgIMKgIMKgIG1heCByZXdpbmQ6IDMyIEtpQjxicj4KwqAgwqAgwqAgwqAgbW9uaXRvciBz
b3VyY2U6IDA8YnI+CsKgIMKgIMKgIMKgIHNhbXBsZSBzcGVjOiBzMTZsZSAyY2ggNDgwMDBIejxi
cj4KwqAgwqAgwqAgwqAgY2hhbm5lbCBtYXA6IGZyb250LWxlZnQsZnJvbnQtcmlnaHQ8YnI+CsKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgU3RlcmVvPGJyPgrCoCDCoCDCoCDCoCB1c2Vk
IGJ5OiAwPGJyPgrCoCDCoCDCoCDCoCBsaW5rZWQgYnk6IDM8YnI+CsKgIMKgIMKgIMKgIGNvbmZp
Z3VyZWQgbGF0ZW5jeTogODYuMDAgbXM7IHJhbmdlIGlzIDg2LjAwIC4uIDE3MC42NyBtczxicj4K
wqAgwqAgwqAgwqAgY2FyZDogMCAmbHQ7YWxzYV9jYXJkLnBsYXRmb3JtLXNvdW5kLjEzJmd0Ozxi
cj4KwqAgwqAgwqAgwqAgbW9kdWxlOiA2PGJyPgrCoCDCoCDCoCDCoCBwcm9wZXJ0aWVzOjxicj4K
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYWxzYS5yZXNvbHV0aW9uX2JpdHMgPSAmcXVvdDsxNiZx
dW90Ozxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZGV2aWNlLmFwaSA9ICZxdW90O2Fsc2Em
cXVvdDs8YnI+CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGRldmljZS5jbGFzcyA9ICZxdW90O3Nv
dW5kJnF1b3Q7PGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBhbHNhLmNsYXNzID0gJnF1b3Q7
Z2VuZXJpYyZxdW90Ozxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYWxzYS5zdWJjbGFzcyA9
ICZxdW90O2dlbmVyaWMtbWl4JnF1b3Q7PGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YSBo
cmVmPSJodHRwOi8vYWxzYS5uYW1lIiB0YXJnZXQ9Il9ibGFuayI+YWxzYS5uYW1lPC9hPiA9ICZx
dW90OyZxdW90Ozxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGEgaHJlZj0iaHR0cDovL2Fs
c2EuaWQiIHRhcmdldD0iX2JsYW5rIj5hbHNhLmlkPC9hPiA9ICZxdW90O2kyczAtc2VjIEhpRmkt
MCZxdW90Ozxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYWxzYS5zdWJkZXZpY2UgPSAmcXVv
dDswJnF1b3Q7PGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBhbHNhLnN1YmRldmljZV9uYW1l
ID0gJnF1b3Q7c3ViZGV2aWNlICMwJnF1b3Q7PGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBh
bHNhLmRldmljZSA9ICZxdW90OzAmcXVvdDs8YnI+CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGFs
c2EuY2FyZCA9ICZxdW90OzAmcXVvdDs8YnI+CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGFsc2Eu
Y2FyZF9uYW1lID0gJnF1b3Q7eHh4LWF1ZGlvJnF1b3Q7PGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBhbHNhLmxvbmdfY2FyZF9uYW1lID0gJnF1b3Q7eHh4LWF1ZGlvJnF1b3Q7PGJyPgrCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBkZXZpY2UuYnVzX3BhdGggPSAmcXVvdDtwbGF0Zm9ybS1zb3Vu
ZC4xMyZxdW90Ozxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc3lzZnMucGF0aCA9ICZxdW90
Oy9kZXZpY2VzL3NvdW5kLjEzL3NvdW5kLzx3YnI+Y2FyZDAmcXVvdDs8YnI+CsKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIGRldmljZS5zdHJpbmcgPSAmcXVvdDtodzowJnF1b3Q7PGJyPgrCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBkZXZpY2UuYnVmZmVyaW5nLmJ1ZmZlcl9zaXplID0gJnF1b3Q7MzI3
NjgmcXVvdDs8YnI+CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGRldmljZS5idWZmZXJpbmcuZnJh
Z21lbnRfc2l6ZSA9ICZxdW90OzE2Mzg0JnF1b3Q7PGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBkZXZpY2UuYWNjZXNzX21vZGUgPSAmcXVvdDttbWFwK3RpbWVyJnF1b3Q7PGJyPgrCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCA8YSBocmVmPSJodHRwOi8vZGV2aWNlLnByb2ZpbGUubmFtZSIgdGFy
Z2V0PSJfYmxhbmsiPmRldmljZS5wcm9maWxlLm5hbWU8L2E+ID0gJnF1b3Q7YW5hbG9nLXN0ZXJl
byZxdW90Ozxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZGV2aWNlLnByb2ZpbGUuZGVzY3Jp
cHRpb24gPSAmcXVvdDtBbmFsb2cgU3RlcmVvJnF1b3Q7PGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBkZXZpY2UuZGVzY3JpcHRpb24gPSAmcXVvdDthdWRpbyBBbmFsb2cgU3RlcmVvJnF1b3Q7
PGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBtb2R1bGUtdWRldi1kZXRlY3QuZGlzY292ZXJl
ZCA9ICZxdW90OzEmcXVvdDs8YnI+CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGRldmljZS5pY29u
X25hbWUgPSAmcXVvdDthdWRpby1jYXJkJnF1b3Q7PGJyPgrCoCDCoCDCoCDCoCBwb3J0czo8YnI+
CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGFuYWxvZy1vdXRwdXQ6IEFuYWxvZyBPdXRwdXQgKHBy
aW9yaXR5IDk5MDAsIGxhdGVuY3k8YnI+Cm9mZnNldCAwIHVzZWMsIGF2YWlsYWJsZTogdW5rbm93
bik8YnI+CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHByb3BlcnRpZXM6PGJy
Pgo8YnI+CsKgIMKgIMKgIMKgIGFjdGl2ZSBwb3J0OiAmbHQ7YW5hbG9nLW91dHB1dCZndDs8YnI+
CsKgIMKgIGluZGV4OiAxPGJyPgrCoCDCoCDCoCDCoCBuYW1lOiAmbHQ7Ymx1ZXpfc2luay44MF8w
MV84NF8xQ18xRl9FQSZndDs8YnI+CsKgIMKgIMKgIMKgIGRyaXZlcjogJmx0O21vZHVsZS1ibHVl
ejUtZGV2aWNlLmMmZ3Q7PGJyPgrCoCDCoCDCoCDCoCBmbGFnczogSEFSRFdBUkUgREVDSUJFTF9W
T0xVTUUgTEFURU5DWSBGTEFUX1ZPTFVNRTxicj4KwqAgwqAgwqAgwqAgc3RhdGU6IFNVU1BFTkRF
RDxicj4KwqAgwqAgwqAgwqAgc3VzcGVuZCBjYXVzZTogVVNFUjxicj4KwqAgwqAgwqAgwqAgcHJp
b3JpdHk6IDkwMzA8YnI+CsKgIMKgIMKgIMKgIHZvbHVtZTogbW9ubzogNjU1MzYgLyAxMDAlIC8g
MC4wMCBkQjxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYmFsYW5jZSAwLjAwPGJyPgrCoCDC
oCDCoCDCoCBiYXNlIHZvbHVtZTogNjU1MzYgLyAxMDAlIC8gMC4wMCBkQjxicj4KwqAgwqAgwqAg
wqAgdm9sdW1lIHN0ZXBzOiA2NTUzNzxicj4KwqAgwqAgwqAgwqAgbXV0ZWQ6IG5vPGJyPgrCoCDC
oCDCoCDCoCBjdXJyZW50IGxhdGVuY3k6IDAuMDAgbXM8YnI+CsKgIMKgIMKgIMKgIG1heCByZXF1
ZXN0OiAwIEtpQjxicj4KwqAgwqAgwqAgwqAgbWF4IHJld2luZDogMCBLaUI8YnI+CsKgIMKgIMKg
IMKgIG1vbml0b3Igc291cmNlOiAxPGJyPgrCoCDCoCDCoCDCoCBzYW1wbGUgc3BlYzogczE2bGUg
MWNoIDgwMDBIejxicj4KwqAgwqAgwqAgwqAgY2hhbm5lbCBtYXA6IG1vbm88YnI+CsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgTW9ubzxicj4KwqAgwqAgwqAgwqAgdXNlZCBieTogMTxi
cj4KwqAgwqAgwqAgwqAgbGlua2VkIGJ5OiAxPGJyPgrCoCDCoCDCoCDCoCBmaXhlZCBsYXRlbmN5
OiAxMjguMDAgbXM8YnI+CsKgIMKgIMKgIMKgIGNhcmQ6IDEgJmx0O2JsdWV6X2NhcmQuODBfMDFf
ODRfMUNfMUZfRUEmZ3Q7PGJyPgrCoCDCoCDCoCDCoCBtb2R1bGU6IDIyPGJyPgrCoCDCoCDCoCDC
oCBwcm9wZXJ0aWVzOjxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYmx1ZXRvb3RoLnByb3Rv
Y29sID0gJnF1b3Q7aGVhZHNldF9hdWRpb19nYXRld2F5JnF1b3Q7PGJyPgrCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBkZXZpY2UuZGVzY3JpcHRpb24gPSAmcXVvdDtSYWphIHJhc2hpZCZxdW90Ozxi
cj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZGV2aWNlLnN0cmluZyA9ICZxdW90OzgwOjAxOjg0
OjFDOjFGOkVBJnF1b3Q7PGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBkZXZpY2UuYXBpID0g
JnF1b3Q7Ymx1ZXomcXVvdDs8YnI+CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGRldmljZS5jbGFz
cyA9ICZxdW90O3NvdW5kJnF1b3Q7PGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBkZXZpY2Uu
YnVzID0gJnF1b3Q7Ymx1ZXRvb3RoJnF1b3Q7PGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBk
ZXZpY2UuZm9ybV9mYWN0b3IgPSAmcXVvdDtwaG9uZSZxdW90Ozxicj4KwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgYmx1ZXoucGF0aCA9ICZxdW90Oy9vcmcvYmx1ZXovaGNpMC9kZXZfODBfMDFfODRf
PHdicj4xQ18xRl9FQSZxdW90Ozxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYmx1ZXouY2xh
c3MgPSAmcXVvdDsweDVhMDIwYyZxdW90Ozxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYmx1
ZXouYWxpYXMgPSAmcXVvdDtSYWphIHJhc2hpZCZxdW90Ozxicj4KwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgZGV2aWNlLmljb25fbmFtZSA9ICZxdW90O2F1ZGlvLWNhcmQtYmx1ZXRvb3RoJnF1b3Q7
PGJyPgrCoCDCoCDCoCDCoCBwb3J0czo8YnI+CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHBob25l
LW91dHB1dDogUGhvbmUgKHByaW9yaXR5IDAsIGxhdGVuY3kgb2Zmc2V0IDA8YnI+CnVzZWMsIGF2
YWlsYWJsZTogeWVzKTxicj4KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcHJv
cGVydGllczo8YnI+Cjxicj4KwqAgwqAgwqAgwqAgYWN0aXZlIHBvcnQ6ICZsdDtwaG9uZS1vdXRw
dXQmZ3Q7PGJyPgo8YnI+CldoYXQgY291bGQgYmUgdGhlIHBvc3NpYmxlIHJlYXNvbnMgZm9yIHRo
ZSBzb3VuZCBpcyBub3QgY29taW5nIG9ubHk8YnI+CndoZW4gSEZQIGlzIGFjdGl2ZS4gSXMgdGhl
cmUgYW55IGV4dHJhIGNvbmZpZ3VyYXRpb25zIEkgaGF2ZSB0byBhZGQuPGJyPgpQbGVhc2Ugc3Vn
Z2VzdC48YnI+ClRoYW5rcyBpbiBhZHZhbmNlPGJyPgo8YnI+CldpdGggUmVnYXJkczxicj4KPGJy
PgpTaW50aHUgUmFqYTxicj4KPGJyPjxicj48YnI+LS0gPGJyPjxkaXYgZGlyPSJsdHIiPldpdGgg
UmVnYXJkczxkaXY+PGJyPjwvZGl2PjxkaXY+U2ludGh1IFJhamE8L2Rpdj48L2Rpdj48YnI+Cg==

--===============7617252193929916864==--


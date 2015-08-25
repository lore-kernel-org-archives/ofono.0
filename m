Content-Type: multipart/mixed; boundary="===============5146960462931215688=="
MIME-Version: 1.0
From: Abhishek Dharmapurikar <abhishek.dharma@gmail.com>
Subject: ERROR:Reject SCO: Agent not registered.
Date: Mon, 24 Aug 2015 23:51:33 -0700
Message-ID: <CALveYN5TamxP2cdHeRpqo_gw3fY_0PPi2qsV_ciFi+8GgF4j6Q@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5146960462931215688==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,
I was trying to setup HFP uing ofono. I have the following setup

Rasperry Pi B+ ( ARM1176JZF-S)
Bluez 5.32
Pulseaudio 6.0
ofono 1.16

Used the following steps
http://padovan.org/blog/2010/02/handsfree-profile-into-bluez-and-ofono/
start pulseaudio, bluetoothd and ofonod
Connect to phone using bluetoothctl
./enable-modem
./dial-number
loopback

I was able to pair my nexus 4 device and use the script ./dial-number which
actually sets a call up. But the audio of the call doesn't route to the
default sink. I see the following error in ofonod

*Reject SCO: Agent not registered*

Which could be the reason for the audio problem.

Things that I have already tried.
Patched http://cgit.freedesktop.org/~jprvita/pulseaudio/ file
bluetooth-headsets-media-api.

Recompiled the raspbian kernel with

*CONFIG_BT_SCOCONFIG_BT_HCIUSB_SCO*
enabled

Added

*Enable =3D Source,Sink,Headset,Gateway,Control,MediaDisable =3D Socket*
to /etc/bluetooth/audio.conf.

Things that could be wrong
When I do a pactl list cards, i see the bluetooth card at #0 with two
profiles.






*        Profiles:                a2dp_source: High Fidelity Capture (A2DP
Source) (sinks: 0, sources: 1, priority: 10, available: yes)
headset_audio_gateway: Headset Audio Gateway (HSP/HFP) (sinks: 1, sources:
1, priority: 20, available: no)                off: Off (sinks: 0, sources:
0, priority: 0, available: yes)        Active Profile: a2dp_source*
But when I try making the headset_audio_gateway the default profile. I get

*$ sudo pactl set-card-profile 0 headset_audio_gatewayFailure: Input/Output
error*

Also read this in the pulseaudio notes
http://www.freedesktop.org/wiki/Software/PulseAudio/Notes/6.0/
"When building PulseAudio, it's possible to choose between "native" and
"ofono" BlueZ 5 headset backends."
How do I specify that I wish to use the ofono headset backend? Is that the
problem?

--===============5146960462931215688==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGksPGJyPkkgd2FzIHRyeWluZyB0byBzZXR1cCBIRlAgdWluZyBvZm9u
by4gSSBoYXZlIHRoZSBmb2xsb3dpbmcgc2V0dXA8YnI+PGJyPlJhc3BlcnJ5IFBpIEIrICggQVJN
MTE3NkpaRi1TKTxicj5CbHVleiA1LjMyPGJyPlB1bHNlYXVkaW8gNi4wPGJyPm9mb25vIDEuMTY8
YnI+PGJyPlVzZWQgdGhlIGZvbGxvd2luZyBzdGVwc8KgPGEgaHJlZj0iaHR0cDovL3BhZG92YW4u
b3JnL2Jsb2cvMjAxMC8wMi9oYW5kc2ZyZWUtcHJvZmlsZS1pbnRvLWJsdWV6LWFuZC1vZm9uby8i
IHRhcmdldD0iX2JsYW5rIj5odHRwOi8vcGFkb3Zhbi5vcmcvYmxvZy8yMDEwLzAyL2hhbmRzZnJl
ZS1wcm9maWxlLWludG8tYmx1ZXotYW5kLW9mb25vLzwvYT48ZGl2PnN0YXJ0IHB1bHNlYXVkaW8s
IGJsdWV0b290aGQgYW5kIG9mb25vZDxicj48ZGl2PkNvbm5lY3QgdG8gcGhvbmUgdXNpbmcgYmx1
ZXRvb3RoY3RsPC9kaXY+PGRpdj4uL2VuYWJsZS1tb2RlbTwvZGl2PjxkaXY+Li9kaWFsLW51bWJl
cjwvZGl2PjxkaXY+bG9vcGJhY2vCoDwvZGl2PjxkaXY+PGJyPjwvZGl2Pkkgd2FzIGFibGUgdG8g
cGFpciBteSBuZXh1cyA0IGRldmljZSBhbmQgdXNlIHRoZSBzY3JpcHQgLi9kaWFsLW51bWJlciB3
aGljaCBhY3R1YWxseSBzZXRzIGEgY2FsbCB1cC4gQnV0IHRoZSBhdWRpbyBvZiB0aGUgY2FsbCBk
b2VzbiYjMzk7dCByb3V0ZSB0byB0aGUgZGVmYXVsdCBzaW5rLiBJIHNlZSB0aGUgZm9sbG93aW5n
IGVycm9yIGluIG9mb25vZCA8YnI+PGk+PGJyPlJlamVjdCBTQ086IEFnZW50IG5vdCByZWdpc3Rl
cmVkPC9pPjxicj48YnI+V2hpY2ggY291bGQgYmUgdGhlIHJlYXNvbiBmb3IgdGhlIGF1ZGlvIHBy
b2JsZW0uPGJyPjxicj5UaGluZ3MgdGhhdCBJIGhhdmUgYWxyZWFkeSB0cmllZC48YnI+UGF0Y2hl
ZCA8YSBocmVmPSJodHRwOi8vY2dpdC5mcmVlZGVza3RvcC5vcmcvfmpwcnZpdGEvcHVsc2VhdWRp
by8iPmh0dHA6Ly9jZ2l0LmZyZWVkZXNrdG9wLm9yZy9+anBydml0YS9wdWxzZWF1ZGlvLzwvYT4g
ZmlsZSBibHVldG9vdGgtaGVhZHNldHMtbWVkaWEtYXBpLjxicj48YnI+UmVjb21waWxlZCB0aGUg
cmFzcGJpYW4ga2VybmVsIHdpdGg8YnI+PGk+Q09ORklHX0JUX1NDTzxicj5DT05GSUdfQlRfSENJ
VVNCX1NDTzwvaT48YnI+ZW5hYmxlZDxicj48YnI+QWRkZWQgPGJyPjxpPkVuYWJsZSA9IFNvdXJj
ZSxTaW5rLEhlYWRzZXQsR2F0ZXdheSxDb250cm9sLE1lZGlhPGJyPkRpc2FibGUgPSBTb2NrZXQ8
L2k+PGJyPnRvIC9ldGMvYmx1ZXRvb3RoL2F1ZGlvLmNvbmYuIDxicj48YnI+VGhpbmdzIHRoYXQg
Y291bGQgYmUgd3Jvbmc8YnI+V2hlbiBJIGRvIGEgcGFjdGwgbGlzdCBjYXJkcywgaSBzZWUgdGhl
IGJsdWV0b290aCBjYXJkIGF0ICMwIHdpdGggdHdvIHByb2ZpbGVzLiA8YnI+PGk+PGJyPsKgIMKg
IMKgIMKgIFByb2ZpbGVzOjxicj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBhMmRwX3NvdXJjZTog
SGlnaCBGaWRlbGl0eSBDYXB0dXJlIChBMkRQIFNvdXJjZSkgKHNpbmtzOiAwLCBzb3VyY2VzOiAx
LCBwcmlvcml0eTogMTAsIGF2YWlsYWJsZTogeWVzKTxicj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBoZWFkc2V0X2F1ZGlvX2dhdGV3YXk6IEhlYWRzZXQgQXVkaW8gR2F0ZXdheSAoSFNQL0hGUCkg
KHNpbmtzOiAxLCBzb3VyY2VzOiAxLCBwcmlvcml0eTogMjAsIGF2YWlsYWJsZTogbm8pPGJyPsKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIG9mZjogT2ZmIChzaW5rczogMCwgc291cmNlczogMCwgcHJp
b3JpdHk6IDAsIGF2YWlsYWJsZTogeWVzKTxicj7CoCDCoCDCoCDCoCBBY3RpdmUgUHJvZmlsZTog
YTJkcF9zb3VyY2U8YnI+PC9pPjxicj5CdXQgd2hlbiBJIHRyeSBtYWtpbmcgdGhlIGhlYWRzZXRf
YXVkaW9fZ2F0ZXdheSB0aGUgZGVmYXVsdCBwcm9maWxlLiBJIGdldCA8YnI+PGk+JCBzdWRvIHBh
Y3RsIHNldC1jYXJkLXByb2ZpbGUgMCBoZWFkc2V0X2F1ZGlvX2dhdGV3YXk8YnI+RmFpbHVyZTog
SW5wdXQvT3V0cHV0IGVycm9yPC9pPjxicj48YnI+QWxzbyByZWFkIHRoaXMgaW4gdGhlIHB1bHNl
YXVkaW8gbm90ZXMgPGEgaHJlZj0iaHR0cDovL3d3dy5mcmVlZGVza3RvcC5vcmcvd2lraS9Tb2Z0
d2FyZS9QdWxzZUF1ZGlvL05vdGVzLzYuMC8iPmh0dHA6Ly93d3cuZnJlZWRlc2t0b3Aub3JnL3dp
a2kvU29mdHdhcmUvUHVsc2VBdWRpby9Ob3Rlcy82LjAvPC9hPjxicj4mcXVvdDtXaGVuIGJ1aWxk
aW5nIFB1bHNlQXVkaW8sIGl0JiMzOTtzIHBvc3NpYmxlIHRvIGNob29zZSBiZXR3ZWVuICZxdW90
O25hdGl2ZSZxdW90OyBhbmQgJnF1b3Q7b2Zvbm8mcXVvdDsgQmx1ZVogNSBoZWFkc2V0IGJhY2tl
bmRzLiZxdW90O8KgPC9kaXY+PGRpdj5Ib3cgZG8gSSBzcGVjaWZ5IHRoYXQgSSB3aXNoIHRvIHVz
ZSB0aGUgb2Zvbm8gaGVhZHNldCBiYWNrZW5kPyBJcyB0aGF0IHRoZSBwcm9ibGVtPzwvZGl2Pjwv
ZGl2Pgo=

--===============5146960462931215688==--


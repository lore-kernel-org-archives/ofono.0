Content-Type: multipart/mixed; boundary="===============3077482361019665520=="
MIME-Version: 1.0
From: Georg Chini <georg@chini.tk>
Subject: Re: ERROR:Reject SCO: Agent not registered.
Date: Tue, 25 Aug 2015 10:47:03 +0200
Message-ID: <55DC2B87.7020901@chini.tk>
In-Reply-To: <CALveYN5TamxP2cdHeRpqo_gw3fY_0PPi2qsV_ciFi+8GgF4j6Q@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3077482361019665520==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 25.08.2015 08:51, Abhishek Dharmapurikar wrote:
> Hi,
> I was trying to setup HFP uing ofono. I have the following setup
>
> Rasperry Pi B+ ( ARM1176JZF-S)
> Bluez 5.32
> Pulseaudio 6.0
> ofono 1.16
>
> Used the following steps =

> http://padovan.org/blog/2010/02/handsfree-profile-into-bluez-and-ofono/
> start pulseaudio, bluetoothd and ofonod
> Connect to phone using bluetoothctl
> ./enable-modem
> ./dial-number
> loopback
>
> I was able to pair my nexus 4 device and use the script ./dial-number =

> which actually sets a call up. But the audio of the call doesn't route =

> to the default sink. I see the following error in ofonod
> /
> Reject SCO: Agent not registered/
>
> Which could be the reason for the audio problem.
>
> Things that I have already tried.
> Patched http://cgit.freedesktop.org/~jprvita/pulseaudio/ =

> <http://cgit.freedesktop.org/%7Ejprvita/pulseaudio/> file =

> bluetooth-headsets-media-api.
>
> Recompiled the raspbian kernel with
> /CONFIG_BT_SCO
> CONFIG_BT_HCIUSB_SCO/
> enabled
>
> Added
> /Enable =3D Source,Sink,Headset,Gateway,Control,Media
> Disable =3D Socket/
> to /etc/bluetooth/audio.conf.
>
> Things that could be wrong
> When I do a pactl list cards, i see the bluetooth card at #0 with two =

> profiles.
> /
>         Profiles:
>                 a2dp_source: High Fidelity Capture (A2DP Source) =

> (sinks: 0, sources: 1, priority: 10, available: yes)
>                 headset_audio_gateway: Headset Audio Gateway (HSP/HFP) =

> (sinks: 1, sources: 1, priority: 20, available: no)
>                 off: Off (sinks: 0, sources: 0, priority: 0, =

> available: yes)
>         Active Profile: a2dp_source
> /
> But when I try making the headset_audio_gateway the default profile. I =

> get
> /$ sudo pactl set-card-profile 0 headset_audio_gateway
> Failure: Input/Output error/
>
> Also read this in the pulseaudio notes =

> http://www.freedesktop.org/wiki/Software/PulseAudio/Notes/6.0/
> "When building PulseAudio, it's possible to choose between "native" =

> and "ofono" BlueZ 5 headset backends."
> How do I specify that I wish to use the ofono headset backend? Is that =

> the problem?
>
Hi,

most of what you find on the web is outdated (like the link above) =

because it refers
to Bluez 4 which has a completely different API compared to Bluez 5. But =

nevertheless
the combination you are using should work. In pulseaudio you have to =

enable ofono
support by adding the parameter "headset=3Dofono" to =

module-bluetooth-discover in
default.pa. See also
http://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/User/Modu=
les/#index35h3

Regards
              Georg

--===============3077482361019665520==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CiAgPGhlYWQ+CiAgICA8bWV0YSBjb250ZW50PSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9d2lu
ZG93cy0xMjUyIgogICAgICBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiPgogIDwvaGVhZD4KICA8
Ym9keSBiZ2NvbG9yPSIjRkZGRkZGIiB0ZXh0PSIjMDAwMDAwIj4KICAgIDxkaXYgY2xhc3M9Im1v
ei1jaXRlLXByZWZpeCI+T24gMjUuMDguMjAxNSAwODo1MSwgQWJoaXNoZWsKICAgICAgRGhhcm1h
cHVyaWthciB3cm90ZTo8YnI+CiAgICA8L2Rpdj4KICAgIDxibG9ja3F1b3RlCmNpdGU9Im1pZDpD
QUx2ZVlONVRhbXhQMmNkSGVScHFvX2d3M2ZZXzBQUGkycXNWX2NpRmkrOEdnRjRqNlFAbWFpbC5n
bWFpbC5jb20iCiAgICAgIHR5cGU9ImNpdGUiPgogICAgICA8ZGl2IGRpcj0ibHRyIj5IaSw8YnI+
CiAgICAgICAgSSB3YXMgdHJ5aW5nIHRvIHNldHVwIEhGUCB1aW5nIG9mb25vLiBJIGhhdmUgdGhl
IGZvbGxvd2luZyBzZXR1cDxicj4KICAgICAgICA8YnI+CiAgICAgICAgUmFzcGVycnkgUGkgQisg
KCBBUk0xMTc2SlpGLVMpPGJyPgogICAgICAgIEJsdWV6IDUuMzI8YnI+CiAgICAgICAgUHVsc2Vh
dWRpbyA2LjA8YnI+CiAgICAgICAgb2Zvbm8gMS4xNjxicj4KICAgICAgICA8YnI+CiAgICAgICAg
VXNlZCB0aGUgZm9sbG93aW5nIHN0ZXBzoDxhIG1vei1kby1ub3Qtc2VuZD0idHJ1ZSIKaHJlZj0i
aHR0cDovL3BhZG92YW4ub3JnL2Jsb2cvMjAxMC8wMi9oYW5kc2ZyZWUtcHJvZmlsZS1pbnRvLWJs
dWV6LWFuZC1vZm9uby8iCiAgICAgICAgICB0YXJnZXQ9Il9ibGFuayI+aHR0cDovL3BhZG92YW4u
b3JnL2Jsb2cvMjAxMC8wMi9oYW5kc2ZyZWUtcHJvZmlsZS1pbnRvLWJsdWV6LWFuZC1vZm9uby88
L2E+CiAgICAgICAgPGRpdj5zdGFydCBwdWxzZWF1ZGlvLCBibHVldG9vdGhkIGFuZCBvZm9ub2Q8
YnI+CiAgICAgICAgICA8ZGl2PkNvbm5lY3QgdG8gcGhvbmUgdXNpbmcgYmx1ZXRvb3RoY3RsPC9k
aXY+CiAgICAgICAgICA8ZGl2Pi4vZW5hYmxlLW1vZGVtPC9kaXY+CiAgICAgICAgICA8ZGl2Pi4v
ZGlhbC1udW1iZXI8L2Rpdj4KICAgICAgICAgIDxkaXY+bG9vcGJhY2ugPC9kaXY+CiAgICAgICAg
ICA8ZGl2Pjxicj4KICAgICAgICAgIDwvZGl2PgogICAgICAgICAgSSB3YXMgYWJsZSB0byBwYWly
IG15IG5leHVzIDQgZGV2aWNlIGFuZCB1c2UgdGhlIHNjcmlwdAogICAgICAgICAgLi9kaWFsLW51
bWJlciB3aGljaCBhY3R1YWxseSBzZXRzIGEgY2FsbCB1cC4gQnV0IHRoZSBhdWRpbyBvZgogICAg
ICAgICAgdGhlIGNhbGwgZG9lc24ndCByb3V0ZSB0byB0aGUgZGVmYXVsdCBzaW5rLiBJIHNlZSB0
aGUKICAgICAgICAgIGZvbGxvd2luZyBlcnJvciBpbiBvZm9ub2QgPGJyPgogICAgICAgICAgPGk+
PGJyPgogICAgICAgICAgICBSZWplY3QgU0NPOiBBZ2VudCBub3QgcmVnaXN0ZXJlZDwvaT48YnI+
CiAgICAgICAgICA8YnI+CiAgICAgICAgICBXaGljaCBjb3VsZCBiZSB0aGUgcmVhc29uIGZvciB0
aGUgYXVkaW8gcHJvYmxlbS48YnI+CiAgICAgICAgICA8YnI+CiAgICAgICAgICBUaGluZ3MgdGhh
dCBJIGhhdmUgYWxyZWFkeSB0cmllZC48YnI+CiAgICAgICAgICBQYXRjaGVkIDxhIG1vei1kby1u
b3Qtc2VuZD0idHJ1ZSIKICAgICAgICAgICAgaHJlZj0iaHR0cDovL2NnaXQuZnJlZWRlc2t0b3Au
b3JnLyU3RWpwcnZpdGEvcHVsc2VhdWRpby8iPmh0dHA6Ly9jZ2l0LmZyZWVkZXNrdG9wLm9yZy9+
anBydml0YS9wdWxzZWF1ZGlvLzwvYT4KICAgICAgICAgIGZpbGUgYmx1ZXRvb3RoLWhlYWRzZXRz
LW1lZGlhLWFwaS48YnI+CiAgICAgICAgICA8YnI+CiAgICAgICAgICBSZWNvbXBpbGVkIHRoZSBy
YXNwYmlhbiBrZXJuZWwgd2l0aDxicj4KICAgICAgICAgIDxpPkNPTkZJR19CVF9TQ088YnI+CiAg
ICAgICAgICAgIENPTkZJR19CVF9IQ0lVU0JfU0NPPC9pPjxicj4KICAgICAgICAgIGVuYWJsZWQ8
YnI+CiAgICAgICAgICA8YnI+CiAgICAgICAgICBBZGRlZCA8YnI+CiAgICAgICAgICA8aT5FbmFi
bGUgPSBTb3VyY2UsU2luayxIZWFkc2V0LEdhdGV3YXksQ29udHJvbCxNZWRpYTxicj4KICAgICAg
ICAgICAgRGlzYWJsZSA9IFNvY2tldDwvaT48YnI+CiAgICAgICAgICB0byAvZXRjL2JsdWV0b290
aC9hdWRpby5jb25mLiA8YnI+CiAgICAgICAgICA8YnI+CiAgICAgICAgICBUaGluZ3MgdGhhdCBj
b3VsZCBiZSB3cm9uZzxicj4KICAgICAgICAgIFdoZW4gSSBkbyBhIHBhY3RsIGxpc3QgY2FyZHMs
IGkgc2VlIHRoZSBibHVldG9vdGggY2FyZCBhdCAjMAogICAgICAgICAgd2l0aCB0d28gcHJvZmls
ZXMuIDxicj4KICAgICAgICAgIDxpPjxicj4KICAgICAgICAgICAgoCCgIKAgoCBQcm9maWxlczo8
YnI+CiAgICAgICAgICAgIKAgoCCgIKAgoCCgIKAgoCBhMmRwX3NvdXJjZTogSGlnaCBGaWRlbGl0
eSBDYXB0dXJlIChBMkRQCiAgICAgICAgICAgIFNvdXJjZSkgKHNpbmtzOiAwLCBzb3VyY2VzOiAx
LCBwcmlvcml0eTogMTAsIGF2YWlsYWJsZTogeWVzKTxicj4KICAgICAgICAgICAgoCCgIKAgoCCg
IKAgoCCgIGhlYWRzZXRfYXVkaW9fZ2F0ZXdheTogSGVhZHNldCBBdWRpbyBHYXRld2F5CiAgICAg
ICAgICAgIChIU1AvSEZQKSAoc2lua3M6IDEsIHNvdXJjZXM6IDEsIHByaW9yaXR5OiAyMCwgYXZh
aWxhYmxlOgogICAgICAgICAgICBubyk8YnI+CiAgICAgICAgICAgIKAgoCCgIKAgoCCgIKAgoCBv
ZmY6IE9mZiAoc2lua3M6IDAsIHNvdXJjZXM6IDAsIHByaW9yaXR5OiAwLAogICAgICAgICAgICBh
dmFpbGFibGU6IHllcyk8YnI+CiAgICAgICAgICAgIKAgoCCgIKAgQWN0aXZlIFByb2ZpbGU6IGEy
ZHBfc291cmNlPGJyPgogICAgICAgICAgPC9pPjxicj4KICAgICAgICAgIEJ1dCB3aGVuIEkgdHJ5
IG1ha2luZyB0aGUgaGVhZHNldF9hdWRpb19nYXRld2F5IHRoZSBkZWZhdWx0CiAgICAgICAgICBw
cm9maWxlLiBJIGdldCA8YnI+CiAgICAgICAgICA8aT4kIHN1ZG8gcGFjdGwgc2V0LWNhcmQtcHJv
ZmlsZSAwIGhlYWRzZXRfYXVkaW9fZ2F0ZXdheTxicj4KICAgICAgICAgICAgRmFpbHVyZTogSW5w
dXQvT3V0cHV0IGVycm9yPC9pPjxicj4KICAgICAgICAgIDxicj4KICAgICAgICAgIEFsc28gcmVh
ZCB0aGlzIGluIHRoZSBwdWxzZWF1ZGlvIG5vdGVzIDxhCiAgICAgICAgICAgIG1vei1kby1ub3Qt
c2VuZD0idHJ1ZSIKICAgICAgICAgICAgaHJlZj0iaHR0cDovL3d3dy5mcmVlZGVza3RvcC5vcmcv
d2lraS9Tb2Z0d2FyZS9QdWxzZUF1ZGlvL05vdGVzLzYuMC8iPmh0dHA6Ly93d3cuZnJlZWRlc2t0
b3Aub3JnL3dpa2kvU29mdHdhcmUvUHVsc2VBdWRpby9Ob3Rlcy82LjAvPC9hPjxicj4KICAgICAg
ICAgICJXaGVuIGJ1aWxkaW5nIFB1bHNlQXVkaW8sIGl0J3MgcG9zc2libGUgdG8gY2hvb3NlIGJl
dHdlZW4KICAgICAgICAgICJuYXRpdmUiIGFuZCAib2Zvbm8iIEJsdWVaIDUgaGVhZHNldCBiYWNr
ZW5kcy4ioDwvZGl2PgogICAgICAgIDxkaXY+SG93IGRvIEkgc3BlY2lmeSB0aGF0IEkgd2lzaCB0
byB1c2UgdGhlIG9mb25vIGhlYWRzZXQKICAgICAgICAgIGJhY2tlbmQ/IElzIHRoYXQgdGhlIHBy
b2JsZW0/PC9kaXY+CiAgICAgIDwvZGl2PgogICAgICA8YnI+CiAgICA8L2Jsb2NrcXVvdGU+CiAg
ICBIaSw8YnI+CiAgICA8YnI+CiAgICBtb3N0IG9mIHdoYXQgeW91IGZpbmQgb24gdGhlIHdlYiBp
cyBvdXRkYXRlZCAobGlrZSB0aGUgbGluayBhYm92ZSkKICAgIGJlY2F1c2UgaXQgcmVmZXJzPGJy
PgogICAgdG8gQmx1ZXogNCB3aGljaCBoYXMgYSBjb21wbGV0ZWx5IGRpZmZlcmVudCBBUEkgY29t
cGFyZWQgdG8gQmx1ZXogNS4KICAgIEJ1dCBuZXZlcnRoZWxlc3M8YnI+CiAgICB0aGUgY29tYmlu
YXRpb24geW91IGFyZSB1c2luZyBzaG91bGQgd29yay4gSW4gcHVsc2VhdWRpbyB5b3UgaGF2ZSB0
bwogICAgZW5hYmxlIG9mb25vPGJyPgogICAgc3VwcG9ydCBieSBhZGRpbmcgdGhlIHBhcmFtZXRl
ciAiaGVhZHNldD1vZm9ubyIgdG8KICAgIG1vZHVsZS1ibHVldG9vdGgtZGlzY292ZXIgaW48YnI+
CiAgICBkZWZhdWx0LnBhLiBTZWUgYWxzbzxicj4KPGEgY2xhc3M9Im1vei10eHQtbGluay1mcmVl
dGV4dCIgaHJlZj0iaHR0cDovL3d3dy5mcmVlZGVza3RvcC5vcmcvd2lraS9Tb2Z0d2FyZS9QdWxz
ZUF1ZGlvL0RvY3VtZW50YXRpb24vVXNlci9Nb2R1bGVzLyNpbmRleDM1aDMiPmh0dHA6Ly93d3cu
ZnJlZWRlc2t0b3Aub3JnL3dpa2kvU29mdHdhcmUvUHVsc2VBdWRpby9Eb2N1bWVudGF0aW9uL1Vz
ZXIvTW9kdWxlcy8jaW5kZXgzNWgzPC9hPjxicj4KICAgIDxicj4KICAgIFJlZ2FyZHM8YnI+CiAg
ICCgoKCgoKCgoKCgoKAgR2Vvcmc8YnI+CiAgPC9ib2R5Pgo8L2h0bWw+Cg==

--===============3077482361019665520==--


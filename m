Content-Type: multipart/mixed; boundary="===============0310437669383490842=="
MIME-Version: 1.0
From: zoltanmaric@pm.me
Subject: Re: ofono enable-modem fails with dbus.exceptions.DBusException:
 org.ofono.Error.Failed: Operation failed
Date: Sat, 17 Oct 2020 18:10:13 +0000
Message-ID: <20201017181013.2619.27292@ml01.vlan13.01.org>
In-Reply-To: <20201014210410.GA19086@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0310437669383490842==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Yes, sorry, I should have been clearer on that. The big picture is that I'm=
 trying to make Ubuntu 20.04 recognise AirPods Pro as a headset, and in try=
ing to do so, I've found this AskUbuntu answer: https://askubuntu.com/quest=
ions/831331/failed-to-change-profile-to-headset-head-unit/1236379#1236379

In it, the author suggests that
"My earbuds profiles were A2DP, AVRCP and HFP and no support for HSP. Pulse=
audio only supports HSP out-of-the-box. That's why I couldn't switch to HSP=
/HFP. In order to make HSP/HFP work, you have to enable HFP on pulseaudio w=
hich needs ofono."

And later, they suggest:
"Provide phonesim to ofono. In order to make ofono work, you have to provid=
e a modem to it! You can install a modem emulator called phonesim (implemen=
ted by ofono) to make it work"

And later yet:
"You might have to first enable the modem by executing `enable-modem`"

This is why I tried to run `enable-modem` with phonesim, but I get the erro=
r above. Could you please give me some tips to help debug it?

Thanks,
Zolt=C3=A1n
--===============0310437669383490842==--


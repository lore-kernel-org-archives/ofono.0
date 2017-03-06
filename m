Content-Type: multipart/mixed; boundary="===============1752010142588469786=="
MIME-Version: 1.0
From: Sriram V <vshrirama@gmail.com>
Subject: Pulse Audio issues with Ofono
Date: Mon, 06 Mar 2017 22:06:08 +0530
Message-ID: <CAH9_wRNaD0NNO6n7gC6JeSixt27+Fa6O=bYL9TdAG59DYzcfag@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1752010142588469786==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

I have compiled ofono and am able to dial numbers. (Without Audio
being exercised)

However, when i get a call, my device throws the following messages:

W: [pulseaudio] module-loopback.c: Sample rates too different, not
adjusting (8000 vs. 16340).
W: [pulseaudio] module-loopback.c: Sample rates too different, not
adjusting (8000 vs. 24736).
W: [pulseaudio] module-loopback.c: Sample rates too different, not
adjusting (8000 vs. 33133).
W: [pulseaudio] module-loopback.c: Sample rates too different, not
adjusting (8000 vs. 41530).
W: [pulseaudio] module-loopback.c: Sample rates too different, not
adjusting (8000 vs. 49995).
W: [pulseaudio] module-loopback.c: Sample rates too different, not
adjusting (8000 vs. 58392).
W: [pulseaudio] module-loopback.c: Sample rates too different, not
adjusting (8000 vs. 66788).
W: [pulseaudio] module-loopback.c: Sample rates too different, not
adjusting (8000 vs. 75186).


I see that there is a mismatch of sampling rate. My sound device
supports 8K, 44.1K. I am not
sure what could the problem?

Has anyone see this issue before?


Regards,
sriram

--===============1752010142588469786==--


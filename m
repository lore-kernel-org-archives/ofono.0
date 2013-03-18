Content-Type: multipart/mixed; boundary="===============7501999795957512728=="
MIME-Version: 1.0
From: Viallard Anthony <viallard@syscom-instruments.com>
Subject: Find a way to grab online status when use "hardware flight mode" on
 my board
Date: Mon, 18 Mar 2013 16:23:43 +0100
Message-ID: <5147317F.4050106@syscom-instruments.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7501999795957512728==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello there,

I try to find a way to leave the hardware flight mode. What I mean with =

hardware flight mode that on my board, I can control the flight mode by =

software and also with hardware.

But, when we go to flight mode with hardware, ofono doesn't get it and =

so, doesn't update the "Online" status.

The mainly problem my modem doesn't send messages when goes offline. =

Sometimes, I see "+CSQ: 99,99", "+CREG: 0", "+CGREG: 0". But, It's not =

the case all the times.

So, I think a AT+CFUN? pooling is the best solution in my case. If I =

detect the modem goes offline, I could put ofono up do date.

Have you got a better alternative to my issue ? Where can I do this =

pooling ? IMHO, I think to do this in the plugin driver but maybe there =

are a better place.

This behavior is just for me, I guess you don't want a pooling thing in =

your code :)

Regards,
Anthony.

-- =

.-------------------.-----------------------.-------------------.
| Viallard Anthony  | Syscom Instruments SA | Embedded System   |
| +41 024 455 24 82 | Rue de l'industrie 21 | Software Designer |
| ~~~~~~~~~~~~~~~~~ | 1450 Sainte-Croix     | ~~~~~~~~~~~~~~~~~ |
'-------------------^-----------------------^-------------------^

--===============7501999795957512728==--


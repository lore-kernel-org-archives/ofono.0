Content-Type: multipart/mixed; boundary="===============2981773661949044669=="
MIME-Version: 1.0
From: Pekka Pessi <Pekka.Pessi@nokia.com>
Subject: [RFC] Proposal for flight mode 
Date: Thu, 22 Apr 2010 17:49:57 +0300
Message-ID: <1271947798-16962-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2981773661949044669==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello all,

Here is the first step in adding proper flight mode to ofono. The patch
adds a boolean property "Online" to modem; if that is false, modem is in
flight mode and it has killed its cellular radio.

If the modem driver does not implement online method, the value of the
property is initially true. This feature is intended as temporary. It just
makes the new property as non-intrusive as possible.

There is also a watch list for online/offline state.

The second patch adds the online method to isimodem. The online property of
the isimodem follows the online/offline state of Nokia modems (however, this
has only been tested with N95).

In the next phase, I'll add separate atom lists for flight and online modes.
The old-fashioned post_sim will become post_online. The new method
post_sim_flight will request modem driver to add flight-mode atoms.

--Pekka

BTW, if you have applied the patch I sent earlier today, "usbpnmodem:
configure usbpn interfaces automatically", you can actually try Nokia phones
via USB. They should just work provided you have kernel 2.6.31 or newer
without any manual configuration. Select the "PC suite mode" from the phone
when you connect the USB cable.


--===============2981773661949044669==--


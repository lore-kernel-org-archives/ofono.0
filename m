Content-Type: multipart/mixed; boundary="===============5321902738785820138=="
MIME-Version: 1.0
From: Harald Welte <laforge@gnumonks.org>
Subject: designated way for modems disappearing from bus during +CFUN=1
Date: Mon, 11 Jul 2016 19:37:51 +0200
Message-ID: <20160711173751.GD5250@nataraja>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5321902738785820138==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Dear all,

I've been struggling for quite some time to find out what is the
designated way in ofono to deal with modems that actually perform a
cold/warm reset (and hence USB device stack reset) when you send them an
AT+CFUN=3D1 message.

Examples for this are e.g. the Sierra Wireless SL808x series of modems,
where this behavior is documented and expected.  But I'm sure there are
others, at least I recall having seen this several times in the past.

It is somewhat logical, as a +CFUN+1 is supposed to reset _all_ of the
status in the modem, not just the protocol stack. So the fact that most
modems don't disappear from the bus afterwards actually means that they
are cheating.

The actual behavior of ofono with such a modem is:

* modem first appears as a /wavecom_X device
* if you issue enable_modem via dbus, the modem goes thrugh CFUN=3D1
* the modem disappears from USB, ofono destroys its structures
* the client program (e.g. the one from tests/) simply hangs and fails
  at timeout
* the modem re-enumerates on the bus and ofono creates a new /wavecom_Y
  device, where Y !=3D the X before the modem restart.

So for an application it is not possible to continue to talk to one
modem via dbus accross modem resets.

Not issuing a +CFUN=3D1 is also not really an option, as then you loose
the ability to completely disable the modem.  +CFUN=3D4 can be used to
force an IMSI detach and disable it from the network point of view, but
the modem is still talking to the SIM card and will not re-read SIM
card state if brought back online from +CFUN=3D4.

I'm sure this issue has been seen before, and somebody must have a
solution for it - or at least some ideas on how to solve this in a ofono
driver plugin.  I'm willing to spend some time on it, but my
experience/exposure to the code base is limited.

Thanks in advance.

Regards,
	Harald

-- =

- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.o=
rg/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--===============5321902738785820138==--


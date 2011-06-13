Content-Type: multipart/mixed; boundary="===============9074132723605926087=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Serial Port modems - can ofono help?
Date: Mon, 13 Jun 2011 04:20:00 -0500
Message-ID: <4DF5D640.4080306@gmail.com>
In-Reply-To: <4DF77014.2090002@wildgooses.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9074132723605926087==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ed,

> Thanks could you offer me some reference to what you mean here?  ie does
> ofono offer me something over and above simply a udev rule firing on the
> correct subsystem (and perhaps limiting by driver name if we really want
> to tighten up the rule?)
> =


Nope, it really doesn't.  Well besides maybe an easy integration point
with GAtChat library.

>> If you can combine the two above parts then you might be able to detect
>> modem devices automatically, Marcel had a few ideas how to do this, but
>> nothing concrete has been done yet.
> =

> I need to implement something pretty imminently - just wondering if
> ofono had something to help.  For example is there a "probe this port
> and tell me what modem is on the end" feature? That way I could point it
> at my suspected serial port and ask ofono to scan it?

Nope, there isn't anything like that.  We have plans to implement
something similar, but in the end most of our modems can be easily
detected via udev, or are on platforms with a well known configuration
(e.g. the Freerunner, etc).  So the motivation to do so is not high
right now.  If you manage to make this work nicely (either with oFono or
something else) we'd love to hear about it.

Regards,
-Denis

--===============9074132723605926087==--


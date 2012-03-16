Content-Type: multipart/mixed; boundary="===============5664290598696613440=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Handling AT command with no response
Date: Fri, 16 Mar 2012 16:31:26 -0500
Message-ID: <4F63B12E.6070104@gmail.com>
In-Reply-To: <87zkbgb66n.fsf@neil-laptop.ossau.uklinux.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5664290598696613440==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Neil,

On 03/16/2012 04:13 PM, Neil Jerram wrote:
> Hi there,
> =

> Is there a way in oFono of sending an AT command and not waiting for any
> response?
> =

> Specifically, AT+VTS doesn't give any response according to 27.007, and
> this appears to be true in practice for the Option HSO modem (GTM601).
> =


There is currently no support for this in GAtChat.  Most vendors choose
to return OK here once the tone has been sent to the network and
generated locally.  This is useful when sending multiple tones at once
to know when the sending has finished.  Note that oFono expects a final
response to the 'send_tones' method, so you would need to generate a
reply to the core anyway.

Regards,
-Denis

--===============5664290598696613440==--


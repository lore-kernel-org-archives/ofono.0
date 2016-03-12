Content-Type: multipart/mixed; boundary="===============2115108287226988622=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Timeout/Reliability issue with my plugin
Date: Sat, 12 Mar 2016 09:52:00 -0600
Message-ID: <56E43B20.9090100@gmail.com>
In-Reply-To: <loom.20160312T152722-352@post.gmane.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2115108287226988622==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Holger,

On 03/12/2016 09:03 AM, Holger Freyther wrote:
> Hi,
>
> my plugin is opening the serial on _enable and on _disable it is issuing a
> AT+CFUN=3D0 and waits for the result before discarding the atchat.
>
> $ ./tests/enable-modem /wavecom_0
> ...
> $ lsof | grep ttyUSB0 | wc -l
> 1
>
> $ ./tests/disable-modem /wavecom_0
> $ lsof | grep ttyUSB0 | wc -l
> 0
>
> So far so good. But if I run the above in a loop.. then I see dbus timeou=
ts and
> when I execute lsof.. I see that ofonod has 1023 FDs open. So at some poi=
nt in
> time either the state is messed up or the AT+CFUN doesn't respond.. but w=
e open
> the same device more than once.

Without seeing the modem driver code, I can't comment.  The core does =

set a timeout whenever .set_powered() method is called.  If the method =

does not return in that time, the core does what cleanup that it can. =

Refer to src/modem.c for details.

However, the modem driver is still responsible for cleaning up after =

itself, since the core has no visibility into what resources are being =

used by the modem driver.

>
> Is this known? Does ofono start timers? Does the GAtChat have a way to ti=
meout
> commands and then disclose it? How do other modems handle such situation?
>

GAtChat does not timeout the individual commands.  The atom drivers =

would have no idea what to do with commands that timeout anyway.  And we =

have never needed this capability in practice.  Your modem driver would =

need to handle any modem idiosyncrasies, such as the modem firmware =

resetting on CFUN=3D0 and never returning an OK.

Regards,
-Denis

--===============2115108287226988622==--


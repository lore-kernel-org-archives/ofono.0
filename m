Content-Type: multipart/mixed; boundary="===============4166975959847348284=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: [PATCH 3/5] test-server: Add PPP server support
Date: Tue, 06 Jul 2010 14:23:36 +0800
Message-ID: <33AB447FBD802F4E932063B962385B351F6F2129@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <4C2C9F99.1070003@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4166975959847348284==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Denis Kenzior wrote:
> Hi Zhenhua,
> =

>>> static void server_destroy(gpointer user)
>>> @@ -706,15 +825,11 @@ static void server_destroy(gpointer user)
>>> =

>>> static void set_raw_mode(int fd)
>>> {
>>> -	struct termios options;
>>> -
>>> -	tcgetattr(fd,&options);
>>> -
>>> -	/* Set TTY as raw mode to disable echo back of input characters
>>> -	 * when they are received from Modem to avoid feedback loop */
>>> -	options.c_lflag&=3D ~(ICANON | ECHO | ECHOE | ISIG); +	struct
>>> termios ti; =

>>> =

>>> -	tcsetattr(fd, TCSANOW,&options);
>>> +	tcflush(fd, TCIOFLUSH);
>>> +	cfmakeraw(&ti);
>>> +	tcsetattr(fd, TCSANOW,&ti);
>>> }
>>> =

>>> static gboolean create_tty(const char *modem_path)
>> =

>> I found above changes does not contain latest git tree. The
> part of change is necessary when I tried to use bluetooth
> serial proxy between two machines. Without cfmakeraw, the
> server responses:
>> 	'\r\nOK\r\n'
>> would change to:
>> 	'\n\nOK\n\n'
>> =

>> And this issue doesn't exist if both server and client on the same
>> machine. =

> =

> The above code was causing valgrind to complain, so I left it out,
> apologies for not mentioning it, had a bit of a filesystem disaster
> happen after I pushed :) =

> =

> The present code seems to be completely in line with man cfmakeraw. =

> The cause is probably more subtle or has to do with the RFCOMM tty
> layer in the kernel.  Could you please investigate some more?

The problem lies in that we don't turn off ICRNL flags. If we turns off ICR=
NL, the problem is gone.

	ICRNL  Translate carriage return to newline on input (unless IGNCR is set).

I still recommend to replace current code with cfmakeraw(), so that we don'=
t worry about lower level settings. We just want tty layer passing all char=
acters to our peer correctly.

> Regards,
> -Denis



Regards,
Zhenhua


--===============4166975959847348284==--


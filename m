Content-Type: multipart/mixed; boundary="===============6866063409973879275=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] receive-sms: Support printing received SMS with
 non-ASCII characters
Date: Mon, 24 Nov 2014 12:31:39 -0600
Message-ID: <5473798B.4040306@gmail.com>
In-Reply-To: <1416534506-19999-2-git-send-email-neil@ossau.homelinux.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6866063409973879275==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Neil,

On 11/20/2014 07:48 PM, Neil Jerram wrote:
> Without this I get the following Python traceback, for an SMS that
> contains the UK pound sign.
>
> ERROR:dbus.connection:Exception in handler for D-Bus signal:
> Traceback (most recent call last):
>    File "/usr/lib/python2.7/dist-packages/dbus/connection.py", line 230, =
in maybe_handle_message
>      self._handler(*args, **kwargs)
>    File "./receive-sms", line 9, in incoming_message
>      print("%s" % (message))
> UnicodeEncodeError: 'ascii' codec can't encode character u'\xa3' in posit=
ion 51: ordinal not in range(128)
> ---
>   test/receive-sms | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Patch has been applied, thanks.

Regards,
-Denis


--===============6866063409973879275==--


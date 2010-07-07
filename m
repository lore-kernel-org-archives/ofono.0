Content-Type: multipart/mixed; boundary="===============0601511866217891783=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: [PATCH] test-server: Use cfmakeraw to set TTY raw mode
Date: Wed, 07 Jul 2010 09:28:54 +0800
Message-ID: <33AB447FBD802F4E932063B962385B351F6F23A2@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <1278420710.2789.38.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0601511866217891783==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

Marcel Holtmann wrote:
> Hi Zhenhua,
> =

>> Use cfmakeraw to disable echoing and special characters processing.
>> If we don't turn off ICRNL, TTY layer translates \r\n to \n\n. ---
>>  gatchat/test-server.c |    8 +++-----
>>  1 files changed, 3 insertions(+), 5 deletions(-)
>> =

>> diff --git a/gatchat/test-server.c b/gatchat/test-server.c
>> index 25a1192..2911978 100644
>> --- a/gatchat/test-server.c
>> +++ b/gatchat/test-server.c
>> @@ -848,12 +848,10 @@ static void set_raw_mode(int fd)  {
>>  	struct termios options;
>> =

>> +	memset(&options, 0, sizeof(struct termios));
>>  	tcgetattr(fd, &options);
>> -
>> -	/* Set TTY as raw mode to disable echo back of input characters
>> -	 * when they are received from Modem to avoid feedback loop */
>> -	options.c_lflag &=3D ~(ICANON | ECHO | ECHOE | ISIG); -
>> +	tcflush(fd, TCIOFLUSH);
>> +	cfmakeraw(&options);
>>  	tcsetattr(fd, TCSANOW, &options);
>>  }
> =

> I am fine with using cfmakeraw. So patch has been applied.
> =

> Minor comment here that sizeof(options) would be better then
> referencing the struct itself. And in general we have used ti as
> variable name for termios options. Don't ask me really why. Just have
> done that in the patch. So feel free to send an cleanup patch.

The cleanup patch has been sent. Please review it.
 =

> Regards
> =

> Marcel
> =

> =

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono

Regards,
Zhenhua


--===============0601511866217891783==--


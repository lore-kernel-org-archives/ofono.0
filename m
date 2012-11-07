Content-Type: multipart/mixed; boundary="===============5971087532621125100=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: ofono and connecting to an APN
Date: Wed, 07 Nov 2012 09:04:25 -0600
Message-ID: <509A7879.4000200@gmail.com>
In-Reply-To: <op.wnerbky9yxxkfz@pohanka-pc>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5971087532621125100==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jan,

On 11/07/2012 08:46 AM, Jan Pohanka wrote:
> Hi Denis.
>
>> oFono has its own internal ppp stack, no pppd is required. If your
>> modem supports a high-speed interface, then that should be used instead.
>>
>> And yes, you can do voice calls, sms and internet at the same time
>> with oFono. Assuming of course you have at least two ttys available or
>> your modem supports multiplexing.
>
> Could you please give me some example how to connect a device to

- test/enable-modem
- test/online-modem
- Wait for Attached Property on ConnectionManager interface to go to True
- test/activate-context
- test/process-context-settings

> internet through ofono? When I use pppd I can see a new pppd interface
> in ifconfig. Can ofono do the same?

Yes

>
> I know the test scripts in ofono/test directory, but does there exist
> any more complex ofono client which one can use as a reference?
>

Try the ofono plugin in connman.  In fact, connman can already manage =

internet connections through ofono very well.

Regards,
-Denis

--===============5971087532621125100==--


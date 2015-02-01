Content-Type: multipart/mixed; boundary="===============0198396718928470789=="
MIME-Version: 1.0
From: Norbert Huffschmid <norbert.huffschmid@long-exposure.net>
Subject: Re: ofonod crashes during enable-modem.py
Date: Sun, 01 Feb 2015 15:00:28 +0100
Message-ID: <4DAF1732-7FA7-4211-94DB-DBD69CD04F20@long-exposure.net>
In-Reply-To: <54CDABCB.50805@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0198396718928470789==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

now I have installed ofono from the debian jessie testing branch  =

(which has packaged ofono 1.15-2). Bluez is still version 4.99 and all  =

the rest is debian wheezy as before. Now the list-modems.py script  =

does not show any modem any more. Are there dependency issues?

I already had tried a combination of ofono 1.15-2 and Bluez 5.23,  =

which was quite promising. I could successfully establish a phone call  =

by means of the dial-number.py script. But there was no voice  =

connection established between the endpoints. This was quite  =

astonishing because A2DP streaming from the smartphone to the  =

Raspberry Pi worked like a charm. And I don't think that it was a  =

phone issue because a HFP connection from the phone to a navigation  =

device works well too.

I have read somewhere that Bluez5 does not support HFP at all, so I  =

did not further follow this approach.

Any proposal which combination of ofono and Bluez is most promising in  =

order to establish a HFP voice connection?

Regards,
Norbert

Am 01.02.2015 um 05:30 schrieb Denis Kenzior:

> Hi Norbert,
>
> On 01/31/2015 11:51 AM, Norbert Huffschmid wrote:
>> Hi Denis,
>>
>> this is the full backtrace:
>>
>> (gdb) bt full
>> #0  notify_status_watches (netreg=3D0x100c20) at src/network.c:1182
>
> That's a pretty strange place to have a crash, no idea what's going  =

> on there.  Have you tried the latest upstream version?  1.6 is  =

> pretty old, that's almost 3 years old.
>
> Regards,
> -Denis
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono


--===============0198396718928470789==--


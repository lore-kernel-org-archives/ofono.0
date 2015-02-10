Content-Type: multipart/mixed; boundary="===============2353833733844007933=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Questions about var/lib/ofono/ directories
Date: Mon, 09 Feb 2015 23:49:47 -0600
Message-ID: <54D99BFB.5040503@gmail.com>
In-Reply-To: <54D3A823.8040403@syscom-instruments.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2353833733844007933==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 02/05/2015 11:28 AM, Viallard Anthony wrote:
> Hello ofono mailing list,
>
> I'm wondering what ofono puts in the directory "var/lib/ofono/".
>
> On my embedded device, I can see these directories:
>
>   - var/lib/ofono/228014420910471
>   - var/lib/ofono/228014420910471-3
>
> The number 228014420910471 is the IMSI of my simcard right ?

Yes

>
> In the first one (228014420910471), I can see 3 files called gprs,
> netreg and sms. And there are some configuration in it. It's pretty simpl=
e.
>
> In the other directory, there are 4 files (4f20     6f46     6f49
> version). But I don't understand theirs purposes. Maybe these are SMS
> files ? Why the directory is named <IMSI>-3 ? Other directories with
> another number can be created ?

This is the oFono cache for SIM filesystem files.  Essentially files =

that are not writable by the user on the SIM are cached on the =

filesystem to speed up initialization time.  The suffix (e.g. -3) is the =

SIM phase.  E.g. 3 is 3G/USIM, 2 is 2G/SIM.

>
> I'm wondering this because I want to put this directory and files in a
> separated partition of 1.3MB and put my root partition read only. So I'm
> trying to figure out if it's enough, what kind of files ofono will write
> in it, when and the frequency (it's a NOR flash partition and I would
> like to known if it's a good idea). As I understand, ofono uses this
> directory to store SMS also. But, what kind of SMS ? All the SMS I try
> to send ? All the SMS I received ? I began to read the source code but
> maybe you can tell me some hints.

oFono caches both incoming and outgoing SMS here as well.  For =

reception, the SMS store is used to cache reception of multi-part SMSes, =

e.g. ones longer than could fit into one payload.  For outgoing, the SMS =

is cached here until it has been sent / delivered.

Regards,
-Denis

--===============2353833733844007933==--


Content-Type: multipart/mixed; boundary="===============1967076000756995405=="
MIME-Version: 1.0
From: Viallard Anthony <viallard@syscom-instruments.com>
Subject: Re: Questions about var/lib/ofono/ directories
Date: Tue, 10 Feb 2015 15:32:45 +0100
Message-ID: <54DA168D.2000600@syscom-instruments.com>
In-Reply-To: <54D99BFB.5040503@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1967076000756995405==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 02/10/2015 06:49 AM, Denis Kenzior wrote:
> Hi,
>
> On 02/05/2015 11:28 AM, Viallard Anthony wrote:
>> Hello ofono mailing list,
>>
>> I'm wondering what ofono puts in the directory "var/lib/ofono/".
>>
>> On my embedded device, I can see these directories:
>>
>>   - var/lib/ofono/228014420910471
>>   - var/lib/ofono/228014420910471-3
>>
>> The number 228014420910471 is the IMSI of my simcard right ?
>
> Yes
>
>>
>> In the first one (228014420910471), I can see 3 files called gprs,
>> netreg and sms. And there are some configuration in it. It's pretty
>> simple.
>>
>> In the other directory, there are 4 files (4f20     6f46     6f49
>> version). But I don't understand theirs purposes. Maybe these are SMS
>> files ? Why the directory is named <IMSI>-3 ? Other directories with
>> another number can be created ?
>
> This is the oFono cache for SIM filesystem files.  Essentially files
> that are not writable by the user on the SIM are cached on the
> filesystem to speed up initialization time.  The suffix (e.g. -3) is the
> SIM phase.  E.g. 3 is 3G/USIM, 2 is 2G/SIM.
>
>>
>> I'm wondering this because I want to put this directory and files in a
>> separated partition of 1.3MB and put my root partition read only. So I'm
>> trying to figure out if it's enough, what kind of files ofono will write
>> in it, when and the frequency (it's a NOR flash partition and I would
>> like to known if it's a good idea). As I understand, ofono uses this
>> directory to store SMS also. But, what kind of SMS ? All the SMS I try
>> to send ? All the SMS I received ? I began to read the source code but
>> maybe you can tell me some hints.
>
> oFono caches both incoming and outgoing SMS here as well.  For
> reception, the SMS store is used to cache reception of multi-part SMSes,
> e.g. ones longer than could fit into one payload.  For outgoing, the SMS
> is cached here until it has been sent / delivered.

Ok ! thanks Denis for these information.

I patch a little bit ofono to do what I thought. I split the storage =

directory into two:
  * one directory for SMS, SIM cache file symlinked to our SDCARD storage ;
  * and one directory for settings (gprs, netreg, sms) symlinked to our =

special data partition.

Nice ! It works like a charm !

Regards,
Anthony.



--===============1967076000756995405==--


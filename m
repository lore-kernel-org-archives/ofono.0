Content-Type: multipart/mixed; boundary="===============7165037915056855887=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: SIMCOM support
Date: Thu, 24 Jan 2013 12:21:56 -0600
Message-ID: <51017BC4.4000004@gmail.com>
In-Reply-To: <51016BB8.7090403@syscom-instruments.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7165037915056855887==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Anthony,

On 01/24/2013 11:13 AM, Viallard Anthony wrote:
> On 24. 01. 13 17:21, Denis Kenzior wrote:
>
>> How closely related is this one to SIMCOM 900? We already do have a
>> plugin for it in the tree, so it might be a good idea to merge the two
>> if they are closely related.
>
> I don't known if SIM900 works with my driver plugin. SIMCOM were not
> given us this information whereas we inquired them. It will be glad if
> someone check it.
>
> The only main difference i see between the two plugins, it's the
> AT+CSCS=3D"GSM" command. I don't exactly why there is this command. Maybe
> its a behavior need it to work correctly with the operator where the guy
> has wrote the code and done the test. If someone tell me how to check
> (with an AT command ?) if we need this command, I will do the job.
>

If this is the only difference then the two plugins should be merged. =

Any minor variations can be taken care of by checking the model / =

firmware versions.

The CSCS command is used to set the character set.  It is mostly used to =

make sure basic strings from the modem will be in a format we recognize =

(e.g. phone numbers, operator names, etc).  This setting should =

generally be safe.

>>> * I would like to do a reset of the modem at start and at end of ofono
>>> life (with AT+CFUN=3D6 or AT+CRESET). The purpose is having a modem alw=
ays
>>> in init state for ofono and the others programs. Do you think its a good
>>> idea ?
>>>
>>
>> In general that is not desirable. The modem should be initialized when
>> the enable driver method is called. Why do you want to do this?
>
> I guessed it will be nicer to have this but if you say no, ok, it was
> just an idea to have always a chips in same state at start and when
> ofono stops.
>

The chip should be powered down in disable(), so in theory it will be in =

the same state prior to oFono starting.  Maybe I'm mis-understanding =

what you're trying to do.

Regards,
-Denis

--===============7165037915056855887==--


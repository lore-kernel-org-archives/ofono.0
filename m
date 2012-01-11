Content-Type: multipart/mixed; boundary="===============3386879124355929166=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: [PATCH 2/5] speedup: Check for supported modem capabilities first
Date: Wed, 11 Jan 2012 16:12:03 +0100
Message-ID: <4F0DA6C3.6040808@linux.intel.com>
In-Reply-To: <4F0D6D3B.5090802@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3386879124355929166==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

>>>> We can have a private enum modem type into plugin, but we won't be able
>>>> to use it into any atoms.
>>>> Maybe by deduction we can add an enum sim_type into sim.h store the ty=
pe
>>>> into the plugin data and pass it at SIM atom creation.
>>>> What do you think?
>>> Inside the plugin you can do whatever you want for determining the cdma
>>> vs gsm modem type.  I'm not quite sure I follow your comment about
>>> sim.h...
>> To use only PIN management and retrieving IMSI from current sim atom,
>> sim type (R-UIM or SIM) has to be specified at atom creation.
>> The sim type can is determined into Huawei plugin at the same time as
>> modem type:
>>      - If modem type if GSM, sim type SIM.
>>      - If modem type is CDMA, sim is R-UIM (sim atom is not created in
>> case of UIM/ROMSIM)
> Yes, I understand that part ;)
>
>> I was proposing to have those 2 types into include/sim.h.
>> Thus, sim atom can be flagged as SIM or R-UIM to access or not to the
>> file system and use PIN management only e.g. in:
>> sim_initialize() and sim_initialize_after_pin() we just get the imsi we
>> don't try to read the sim file system.
> And no, we're not going to do it this way.  In the end we must be able
> to read EFs from CDMA modems as well, since many of the EFs exist on
> RUIMs and the logic is exactly the same.  You must find another way

I knew it...
That 's why I have created a new thread that summarize all the concerns =

and ideas we have :)

Kind regards,
Guillaume

--===============3386879124355929166==--


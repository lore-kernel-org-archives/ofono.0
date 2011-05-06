Content-Type: multipart/mixed; boundary="===============1869786172834390074=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Unint var with GCC 4.5.2
Date: Thu, 05 May 2011 21:52:16 -0500
Message-ID: <4DC36260.3020300@gmail.com>
In-Reply-To: <A782C372B9527D44AB20BF45FEEBB14F75C5086BFC@irsmsx503.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1869786172834390074==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

>> Yes, the cache is persistent (stored in IMSI-keyed filesystem location).
>> The logic is supposed to work somewhat like this:
>>
>> 1. Upon sim-atom init, read EFimg and populate its contents in a look up
>> table.
>>
>> 2a. When an application requests an icon with a particular id, look it
>> up in cache or read it from the SIM.  Each icon is assigned to a
>> particular EFiidf_n file.  So record application's interest in that file
>> by assigning a file watch.
>>
>> 2b. If an EFiidf file is refreshed via STK Refresh, call the file watch
>> and remove the file watch.  The file watch will be re-added again once
>> the application requests the icon.
>>
>> However, we have not seen any SIMs with SIM icons, so this part of the
>> code has not been stress tested...
> =

> This cannot tested using PhoneSim?

It can be, guess no one thought of it.

We have already simulated icons with phonesim.  However sending a
refresh for EFiidf hasn't been added to phonesim yet.

Regards,
-Denis

--===============1869786172834390074==--


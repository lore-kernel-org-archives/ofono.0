Content-Type: multipart/mixed; boundary="===============1038780893843764482=="
MIME-Version: 1.0
From: Aygon, Bertrand <bertrand.aygon@intel.com>
Subject: RE: Unint var with GCC 4.5.2
Date: Fri, 06 May 2011 15:09:05 +0100
Message-ID: <A782C372B9527D44AB20BF45FEEBB14F75C5086BFC@irsmsx503.ger.corp.intel.com>
In-Reply-To: <4DC35C1E.80709@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1038780893843764482==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

>> =

>> The unint var is 'unsigned short iidf_id;'
>> =

>> If the image is in the cache, we will go to the watch directly, and if
>> there is no watch, we will add one with an invalid iidf_id.
>> =

>
>This is a bug.  We need to add a watch to the proper iidf_id, which we
>need to obtain from the EFimg look up table.  In the case of a cached
>image, we're not doing that.

Thanks for the clarification. This was my first thought, but getting info f=
rom the writer is always better ;)

Like last time I have found an issue, I guess that you have already make th=
e fix... ;)

>> So is it possible to have an image in the cache without watch?
>
>Yes, the cache is persistent (stored in IMSI-keyed filesystem location).
> The logic is supposed to work somewhat like this:
>
>1. Upon sim-atom init, read EFimg and populate its contents in a look up
>table.
>
>2a. When an application requests an icon with a particular id, look it
>up in cache or read it from the SIM.  Each icon is assigned to a
>particular EFiidf_n file.  So record application's interest in that file
>by assigning a file watch.
>
>2b. If an EFiidf file is refreshed via STK Refresh, call the file watch
>and remove the file watch.  The file watch will be re-added again once
>the application requests the icon.
>
>However, we have not seen any SIMs with SIM icons, so this part of the
>code has not been stress tested...

This cannot tested using PhoneSim?

Regards,

Bertrand
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============1038780893843764482==--


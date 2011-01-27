Content-Type: multipart/mixed; boundary="===============8914165696242132510=="
MIME-Version: 1.0
From: Frederic Danis <frederic.danis@linux.intel.com>
Subject: Re: [PATCH 1/4] bluetooth: only use bluetooth_refcount
 in	bluetooth_ref/bluetooth_unref
Date: Thu, 27 Jan 2011 16:25:16 +0100
Message-ID: <4D418E5C.2040504@linux.intel.com>
In-Reply-To: <1296141124.1520.157.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8914165696242132510==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Le 27/01/2011 16:12, Marcel Holtmann a =C3=A9crit :
> Hi Fred,
>
>>   plugins/bluetooth.c |   14 +++++++++-----
>>   1 files changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
>> index 93dd7a1..e59bd31 100644
>> --- a/plugins/bluetooth.c
>> +++ b/plugins/bluetooth.c
>> @@ -505,7 +505,7 @@ static guint adapter_added_watch;
>>   static guint adapter_removed_watch;
>>   static guint property_watch;
>>
>> -static void bluetooth_ref(void)
>> +static int bluetooth_ref(void)
>>   {
>
> why are we now reverting something back that we already applied
> upstream. Something is wrong here.

I followed Padovan's comment on my first try for this patch :
"bluetooth_refcount can only be read/write by bluetooth_ref/unref"
which seems good to me

-- =

Frederic Danis                            Open Source Technology Centre
frederic.danis(a)intel.com                              Intel Corporation


--===============8914165696242132510==--


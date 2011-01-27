Content-Type: multipart/mixed; boundary="===============8544739616842675921=="
MIME-Version: 1.0
From: Frederic Danis <frederic.danis@linux.intel.com>
Subject: Re: [PATCH 2/4] bluetooth: use GSList instead of GHashTable to	store
 adapter path/address
Date: Thu, 27 Jan 2011 16:35:49 +0100
Message-ID: <4D4190D5.3010007@linux.intel.com>
In-Reply-To: <1296141874.1520.160.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8544739616842675921==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Le 27/01/2011 16:24, Marcel Holtmann a =C3=A9crit :
> Hi Fred,
>
>>>>    plugins/bluetooth.c |   86 ++++++++++++++++++++++++++++++++++++++++=
+++-------
>>>>    1 files changed, 74 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
>>>> index e59bd31..4da662a 100644
>>>> --- a/plugins/bluetooth.c
>>>> +++ b/plugins/bluetooth.c
>>>> @@ -39,9 +39,14 @@
>>>>
>>>>    static DBusConnection *connection;
>>>>    static GHashTable *uuid_hash =3D NULL;
>>>> -static GHashTable *adapter_address_hash =3D NULL;
>>>> +static GSList *adapter_list =3D NULL;
>>>>    static gint bluetooth_refcount;
>>>>
>>>> +struct adapter_address {
>>>> +	char *adapter;
>>>> +	char *address;
>>>> +};
>>>> +
>>>
>>> why are we doing this exactly with a list now instead of a hash table. I
>>> don't see the point here.
>>>
>>
>> In patch 4, I need to find the adapter path (for the incoming
>> connection) from its address to call the authorization method.
>>
>> So, this is why I change to GSList.
>
> you can as easily walk a GHashTable than you can walk a GSList. So why
> not do that instead of moving everything to a list.

I think that find a key from its value may use more cpu from HashTable =

than from GSList. If you want I can remove this and only use HashTable.

-- =

Frederic Danis                            Open Source Technology Centre
frederic.danis(a)intel.com                              Intel Corporation


--===============8544739616842675921==--


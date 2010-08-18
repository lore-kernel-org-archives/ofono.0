Content-Type: multipart/mixed; boundary="===============2601010634353433137=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC_PATCH 2/4] smsutil: Editorial changes to sms status report
 function
Date: Wed, 18 Aug 2010 13:09:01 -0500
Message-ID: <4C6C21BD.90709@gmail.com>
In-Reply-To: <201008182040.47764.petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2601010634353433137==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Petteri,

<snip>

>>> +             node->expiration =3D segment_stat.st_mtime;
>>> +             memcpy(node->mrs, buf, sizeof(node->mrs));
>>> +             memcpy(&node->total_mrs, buf + sizeof(node->mrs),
>>> +                                             sizeof(node->total_mrs));
>>> +             memcpy(&node->sent_mrs,
>>> +                     buf + sizeof(node->mrs) + sizeof(node->total_mrs),
>>> +                     sizeof(node->sent_mrs));
>>> +
>>> +             memcpy(&node->deliverable, buf + sizeof(node->mrs) +
>>> +                     sizeof(node->total_mrs) + sizeof(node->sent_mrs),
>>> +                     sizeof(node->deliverable));
>>
>> To make our lives easier, I'd make the id_table_node structure packed
>> and read the data directly into it.  We don't have to worry about
>> byte-ordering at this point.
>>
> =

> Yep. So, we'll get rid of memcopies, and temp-buffer allocation. So I'll =
change =

> to this:
> =

> struct id_table_node {
> 	struct sms_address to; // =3D> this will be removed
> 	unsigned int mrs[8];
> 	time_t expiration;
> 	unsigned char total_mrs;
> 	unsigned char sent_mrs;
> 	gboolean deliverable;
> } __attribute__((packed));
> =


Yes, this seems just fine to me.  I already removed the to member by the
way. :)

<snip>

>>> +static gboolean sr_assembly_add_fragment_backup(const char *imsi,
>>> +                                     const struct id_table_node *node,
>>> +                                     unsigned int msg_id)
>>> +{
>>> +     int len =3D sizeof(node->mrs) + sizeof(node->total_mrs) +
>>> +                     sizeof(node->sent_mrs) + sizeof(node->deliverable=
);
>>> +     unsigned char buf[len];
>>> +
>>> +     if (!imsi)
>>> +             return FALSE;
>>> +
>>> +     memcpy(buf, node->mrs, sizeof(node->mrs));
>>> +
>>> +     memcpy(buf + sizeof(node->mrs), &node->total_mrs,
>>> +                                     sizeof(node->total_mrs));
>>> +
>>> +     memcpy(buf + sizeof(node->mrs) + sizeof(node->total_mrs),
>>> +                             &node->sent_mrs, sizeof(node->sent_mrs));
>>> +
>>> +     memcpy(buf + sizeof(node->mrs) + sizeof(node->total_mrs) +
>>> +     sizeof(node->sent_mrs), &node->deliverable,
>>> sizeof(node->deliverable)); +
>>
>> Again, simply writing the id_table_node structure might be easier here,
>> especially since you're not taking care of loading the expiration member.
>>
> =

> Good point:) I forgot this expiration-time member :(
> With packed-node type shouldn't be missed anymore. =

> =

> I have to bother you little bit more with status report-expiration logic =
soon, =

> because it's not implemented yet..

Sure :)

We might also need to revisit the address / mr matching.  Some networks
are stupid and rewrite the SMS address in the status report.  E.g. when
I send an SMS to 555-123-4567, the status report comes back with the
address rewritten to +15551234567.

So we might need to allow some fuzzy matching based on the last n digits
or something more clever.

Regards,
-Denis

--===============2601010634353433137==--


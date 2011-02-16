Content-Type: multipart/mixed; boundary="===============2627515121046353494=="
MIME-Version: 1.0
From: Andreas WESTIN <andreas.westin@stericsson.com>
Subject: Re: [PATCH 1/1] src: out of bounds problem in smsutil
Date: Wed, 16 Feb 2011 16:50:18 +0100
Message-ID: <4D5BF23A.4080308@stericsson.com>
In-Reply-To: <4D5BEC5C.3000207@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2627515121046353494==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 2011-02-16 16:25, Denis Kenzior wrote:
> Hi Jessica,
>
> On 02/16/2011 06:04 AM, Jessica Nilsson wrote:
>> ---
>>
>> This one was exposed when wgmodem2.5 CBS was run with valgrind.
>>
>> Best Regards,
>> Jessica Nilsson
>>
>
> Can you post the actual error and the data this happened on?
>
>>   src/smsutil.c |    2 +-
>>   1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/src/smsutil.c b/src/smsutil.c
>> index 5524932..b3a1ba1 100644
>> --- a/src/smsutil.c
>> +++ b/src/smsutil.c
>> @@ -4628,7 +4628,7 @@ char *cbs_topic_ranges_to_string(GSList *ranges)
>>   	}
>>
>>   	/* Space for ranges, commas and terminator null */
>> -	ret =3D g_new(char, len + nelem);
>> +	ret =3D g_new0(char, len + nelem + 1);
>
> I'm having trouble seeing how the old code was wrong.  nelem contains
> the number of elements.  Since the last element does not end with a
> comma, the use of nelem + 1 in g_new is not necessary.  sprintf takes
> care of adding the terminating null, so using g_new0 is also less efficie=
nt.
>
> Are you adding channels that are 5 digits long by any chance?

Valgrind complains that we step outside the allocated memory by 1 byte =

since we loop the string with:

while (*topics !=3D '\0')

the allocated memory is the size of the string and any \0 ends up =

outside. At least that's my interpretation.

I saw it in isimodem/cbs.c in the patches sent in.

This is the output from valgrind:


=3D=3D2450=3D=3D Invalid read of size 1
=3D=3D2450=3D=3D    at 0x3427C: get_topics_len (cbs.c:112)
=3D=3D2450=3D=3D    by 0x347CF: isi_set_topics (cbs.c:223)
=3D=3D2450=3D=3D    by 0xE6343: cbs_set_powered (cbs.c:466)
=3D=3D2450=3D=3D    by 0xE6E4B: cbs_got_file_contents (cbs.c:752)
=3D=3D2450=3D=3D    by 0xE74BF: sim_cbmid_read_cb (cbs.c:889)
=3D=3D2450=3D=3D    by 0x103017: sim_fs_op_read_block_cb (simfs.c:388)
=3D=3D2450=3D=3D    by 0x375C3: isi_read_file_transparent_resp (sim.c:1013)
=3D=3D2450=3D=3D    by 0x19B5B: pending_remove_and_dispatch (modem.c:171)
=3D=3D2450=3D=3D    by 0x19C87: service_dispatch (modem.c:218)
=3D=3D2450=3D=3D    by 0x1A0D7: isi_callback (modem.c:334)
=3D=3D2450=3D=3D    by 0x48D1A4B: g_io_unix_dispatch (giounix.c:162)
=3D=3D2450=3D=3D    by 0x4898117: g_main_context_dispatch (gmain.c:1960)
=3D=3D2450=3D=3D  Address 0x4c031b2 is 0 bytes after a block of size 10 all=
oc'd
=3D=3D2450=3D=3D    at 0x4833F58: malloc (vg_replace_malloc.c:236)
=3D=3D2450=3D=3D    by 0x48D614F: g_malloc (gmem.c:132)
=3D=3D2450=3D=3D    by 0xCE887: cbs_topic_ranges_to_string (smsutil.c:4631)
=3D=3D2450=3D=3D    by 0xE5DC7: cbs_topics_to_str (cbs.c:329)
=3D=3D2450=3D=3D    by 0xE631F: cbs_set_powered (cbs.c:465)
=3D=3D2450=3D=3D    by 0xE6E4B: cbs_got_file_contents (cbs.c:752)
=3D=3D2450=3D=3D    by 0xE74BF: sim_cbmid_read_cb (cbs.c:889)
=3D=3D2450=3D=3D    by 0x103017: sim_fs_op_read_block_cb (simfs.c:388)
=3D=3D2450=3D=3D    by 0x375C3: isi_read_file_transparent_resp (sim.c:1013)
=3D=3D2450=3D=3D    by 0x19B5B: pending_remove_and_dispatch (modem.c:171)
=3D=3D2450=3D=3D    by 0x19C87: service_dispatch (modem.c:218)
=3D=3D2450=3D=3D    by 0x1A0D7: isi_callback (modem.c:334)
=3D=3D2450=3D=3D
=3D=3D2450=3D=3D Invalid read of size 1
=3D=3D2450=3D=3D    at 0x34588: parse_topics (cbs.c:153)
=3D=3D2450=3D=3D    by 0x34957: isi_set_topics (cbs.c:257)
=3D=3D2450=3D=3D    by 0xE6343: cbs_set_powered (cbs.c:466)
=3D=3D2450=3D=3D    by 0xE6E4B: cbs_got_file_contents (cbs.c:752)
=3D=3D2450=3D=3D    by 0xE74BF: sim_cbmid_read_cb (cbs.c:889)
=3D=3D2450=3D=3D    by 0x103017: sim_fs_op_read_block_cb (simfs.c:388)
=3D=3D2450=3D=3D    by 0x375C3: isi_read_file_transparent_resp (sim.c:1013)
=3D=3D2450=3D=3D    by 0x19B5B: pending_remove_and_dispatch (modem.c:171)
=3D=3D2450=3D=3D    by 0x19C87: service_dispatch (modem.c:218)
=3D=3D2450=3D=3D    by 0x1A0D7: isi_callback (modem.c:334)
=3D=3D2450=3D=3D    by 0x48D1A4B: g_io_unix_dispatch (giounix.c:162)
=3D=3D2450=3D=3D    by 0x4898117: g_main_context_dispatch (gmain.c:1960)
=3D=3D2450=3D=3D  Address 0x4c031b2 is 0 bytes after a block of size 10 all=
oc'd
=3D=3D2450=3D=3D    at 0x4833F58: malloc (vg_replace_malloc.c:236)
=3D=3D2450=3D=3D    by 0x48D614F: g_malloc (gmem.c:132)
=3D=3D2450=3D=3D    by 0xCE887: cbs_topic_ranges_to_string (smsutil.c:4631)
=3D=3D2450=3D=3D    by 0xE5DC7: cbs_topics_to_str (cbs.c:329)
=3D=3D2450=3D=3D    by 0xE631F: cbs_set_powered (cbs.c:465)
=3D=3D2450=3D=3D    by 0xE6E4B: cbs_got_file_contents (cbs.c:752)
=3D=3D2450=3D=3D    by 0xE74BF: sim_cbmid_read_cb (cbs.c:889)
=3D=3D2450=3D=3D    by 0x103017: sim_fs_op_read_block_cb (simfs.c:388)
=3D=3D2450=3D=3D    by 0x375C3: isi_read_file_transparent_resp (sim.c:1013)
=3D=3D2450=3D=3D    by 0x19B5B: pending_remove_and_dispatch (modem.c:171)
=3D=3D2450=3D=3D    by 0x19C87: service_dispatch (modem.c:218)
=3D=3D2450=3D=3D    by 0x1A0D7: isi_callback (modem.c:334)

Regards
Andreas


--===============2627515121046353494==--


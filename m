Content-Type: multipart/mixed; boundary="===============0088104874412436321=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [RfC] SIM file watch support.
Date: Sat, 13 Nov 2010 00:35:12 +0100
Message-ID: <AANLkTimThS6uYcSprb3B_ftcfXotDLu_4w5v-cYiUhOp@mail.gmail.com>
In-Reply-To: <4CDC10B8.4000608@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0088104874412436321==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 11 November 2010 16:50, Denis Kenzior <denkenz@gmail.com> wrote:
> On 11/05/2010 07:13 AM, Andrzej Zaborowski wrote:
>> In order to support the Refresh STK command we need to implement at
>> least two types of reset: UICC reset (manufacturer specific) and NAA
>> application reset. =C2=A0Other types can fall back to application reset
>> which can be implemented by removing all atoms and reinitialising them.

[...]

>> stk.c will check if any of the file IDs supplied in the command have
>> any watches on them. =C2=A0If there are only watches with non-NULL
>> callback, it'll call all of them and not reset application. =C2=A0If
>> there are any NULL notifiers, then stk.c will fall back to full
>> application reset. =C2=A0If any of the files were cached, they need to
>> be re-read.
>
> So the last paragraph is confusing me a bit. =C2=A0What is meant by a full
> application reset? =C2=A0Do you mean simulating a sim removal and
> re-insertion as per a UICC reset?

Yes, whatever will cause rerunning sim_initialize.  In terms of the
SIM state state machine I'm not sure if ofono should go back only to
_INSERTED state (in case it was in _READY), or to _NOT_PRESENT and
then immediately _INSERTED.

It looks like some atoms (like cbs) need to start watching SIM state
to find out about imsi changes because they use it to initialise
storage.

Also I'm wondering if we need to clear all of the SIM cache in case of
a Refresh with "UICC reset" or "NAA initialisation", or if we can
assume that the card will first issue a Refresh with File Change
Notification every time a file changes (I'm thinking about the tricky
files like EFust)

>
>> ---
>> =C2=A0src/simfs.h | =C2=A0 12 ++++++++++++
>> =C2=A0src/sim.c =C2=A0 | =C2=A0 21 ++++++++++++++++++++-
>> =C2=A02 files changed, 32 insertions(+), 1 deletions(-)
>>
>> diff --git a/src/simfs.h b/src/simfs.h
>> index ef962db..679955a 100644
>> --- a/src/simfs.h
>> +++ b/src/simfs.h
>> @@ -25,6 +25,8 @@ typedef void (*sim_fs_read_info_cb_t)(int ok, unsigned=
 char file_status,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int total_le=
ngth, int record_length,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *userda=
ta);
>>
>> +typedef void (*sim_fs_ef_notify_t)(int id, void *userdata);
>> +
>> =C2=A0struct sim_fs *sim_fs_new(struct ofono_sim *sim,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct ofono_sim_driver *driver);
>>
>> @@ -48,3 +50,13 @@ char *sim_fs_get_cached_image(struct sim_fs *fs, int =
id);
>> =C2=A0void sim_fs_cache_image(struct sim_fs *fs, const char *image, int =
id);
>>
>> =C2=A0void sim_fs_free(struct sim_fs *fs);
>> +
>> +int sim_fs_add_ef_watch(struct sim_fs *fs, int id,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
sim_fs_ef_notify_t *notify, void *userdata);
>> +
>> +int sim_fs_remove_ef_watch(struct sim_fs *fs, int id,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
sim_fs_ef_notify_t *notify, void *userdata);
>> +
>> +ofono_bool_t sim_fs_has_empty_watches(struct sim_fs *fs, int id);
>
> Shouldn't we be adding the watch functionality to the STK atom? =C2=A0I t=
hink
> logically it belongs there. =C2=A0Otherwise the API seems fine to me.
>
>> +
>> +int sim_fs_notify_file_change(struct sim_fs *fs, int id);
>
> This actually sounds fine. =C2=A0Do you think this function needs to also
> peek inside the currently running queue and terminate the reading of
> files that are changed?

Yes, both are good ideas.  While I think the file watch thing
logically is better in simfs.h, other atoms can't access it there so
it needs to be a SIM atom api.

Best regards

--===============0088104874412436321==--


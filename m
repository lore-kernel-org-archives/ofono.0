Content-Type: multipart/mixed; boundary="===============7135242294341238094=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RfC] SIM file watch support.
Date: Thu, 11 Nov 2010 09:50:16 -0600
Message-ID: <4CDC10B8.4000608@gmail.com>
In-Reply-To: <1288959219-3598-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7135242294341238094==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 11/05/2010 07:13 AM, Andrzej Zaborowski wrote:
> In order to support the Refresh STK command we need to implement at
> least two types of reset: UICC reset (manufacturer specific) and NAA
> application reset.  Other types can fall back to application reset
> which can be implemented by removing all atoms and reinitialising them.
> =

> When we get a Refresh with "File Change Notification" we should first
> check if we're even interested in the file.  We check if the file is
> being watched by any atom and whether the atom can deal with the change
> dynamically.  If not, we fall back to NAA application reset.
> =

> The proposed api lets the users of sim_fs_read register to
> notifications of file change by adding a watch.  In the simplest case
> they can add a "null" watch for a file ID that they care about
> (callback address is NULL), to indicate that the file is important to
> us, but we haven't implemented a way to deal with the contents change
> dynamically, or we can not.
> (Maybe all files being read should automatically become watched, but
> some files might be read only on some user action, in that case we
> don't need to watch them)
> =

> stk.c will check if any of the file IDs supplied in the command have
> any watches on them.  If there are only watches with non-NULL
> callback, it'll call all of them and not reset application.  If
> there are any NULL notifiers, then stk.c will fall back to full
> application reset.  If any of the files were cached, they need to
> be re-read.

So the last paragraph is confusing me a bit.  What is meant by a full
application reset?  Do you mean simulating a sim removal and
re-insertion as per a UICC reset?

> ---
>  src/simfs.h |   12 ++++++++++++
>  src/sim.c   |   21 ++++++++++++++++++++-
>  2 files changed, 32 insertions(+), 1 deletions(-)
> =

> diff --git a/src/simfs.h b/src/simfs.h
> index ef962db..679955a 100644
> --- a/src/simfs.h
> +++ b/src/simfs.h
> @@ -25,6 +25,8 @@ typedef void (*sim_fs_read_info_cb_t)(int ok, unsigned =
char file_status,
>  					int total_length, int record_length,
>  					void *userdata);
>  =

> +typedef void (*sim_fs_ef_notify_t)(int id, void *userdata);
> +
>  struct sim_fs *sim_fs_new(struct ofono_sim *sim,
>  				const struct ofono_sim_driver *driver);
>  =

> @@ -48,3 +50,13 @@ char *sim_fs_get_cached_image(struct sim_fs *fs, int i=
d);
>  void sim_fs_cache_image(struct sim_fs *fs, const char *image, int id);
>  =

>  void sim_fs_free(struct sim_fs *fs);
> +
> +int sim_fs_add_ef_watch(struct sim_fs *fs, int id,
> +			sim_fs_ef_notify_t *notify, void *userdata);
> +
> +int sim_fs_remove_ef_watch(struct sim_fs *fs, int id,
> +			sim_fs_ef_notify_t *notify, void *userdata);
> +
> +ofono_bool_t sim_fs_has_empty_watches(struct sim_fs *fs, int id);

Shouldn't we be adding the watch functionality to the STK atom?  I think
logically it belongs there.  Otherwise the API seems fine to me.

> +
> +int sim_fs_notify_file_change(struct sim_fs *fs, int id);

This actually sounds fine.  Do you think this function needs to also
peek inside the currently running queue and terminate the reading of
files that are changed?

Regards,
-Denis

--===============7135242294341238094==--


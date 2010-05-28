Content-Type: multipart/mixed; boundary="===============3723205898050670906=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC patches 02/13] sms_send_message: add a short roadmap
Date: Fri, 28 May 2010 16:11:51 +0200
Message-ID: <1275055911.4706.72.camel@aeonflux.t-mobile.de>
In-Reply-To: <992d70300e42d2d7d98ff0e4e9fd2c8d3c415932.1274903142.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3723205898050670906==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Inaky,

> From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
> =

> ---
>  src/sms.c |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)
> =

> diff --git a/src/sms.c b/src/sms.c
> index 3a1cff0..594481e 100644
> --- a/src/sms.c
> +++ b/src/sms.c
> @@ -398,6 +398,19 @@ static struct tx_queue_entry *create_tx_queue_entry(=
GSList *msg_list)
>  	return entry;
>  }
>  =

> +/*
> + * Pre-process a SMS text message and deliver it [D-BUS' SendMessage()]
> + *
> + * @conn: D-BUS connection
> + * @msg: message data (telephone number and text)
> + * @data: SMS object to use for transmision
> + *
> + * An alphabet is chosen for the text and it (might be) segmented in
> + * fragments by sms_text_prepare() into @msg_list. A queue list @entry
> + * is created by create_tx_queue_entry() and g_queue_push_tail()
> + * appends that entry to the SMS transmit queue. Then the tx_next()
> + * function is scheduled to run to process the queue.
> + */
>  static DBusMessage *sms_send_message(DBusConnection *conn, DBusMessage *=
msg,
>  					void *data)
>  {

small comments here. So it is D-Bus. That is the official naming in
documentation we settled on some time ago. Half of the documentation
might be still using it wrongly, but we might wanna set a good example
here.

I don't know how picky gtk-doc is about not having the : for title and
the empty line after the title. However this is nicely readable inside
the source code, so I am fine with it.

Regards

Marcel



--===============3723205898050670906==--


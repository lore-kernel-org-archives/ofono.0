Content-Type: multipart/mixed; boundary="===============7735480864476729145=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC patches 12/13] SMS: introduce message ID API
Date: Fri, 28 May 2010 16:27:28 +0200
Message-ID: <1275056848.4706.81.camel@aeonflux.t-mobile.de>
In-Reply-To: <e8b2023003fe700da14aac44c7829665a378ec17.1274903142.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7735480864476729145==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Inaky,

> +/**
> + * Create a random UUID
> + *
> + * \param msg_id Descriptor
> + *
> + * \internal
> + *
> + * Crams the msg_id ID buffer with random 32-bit numbers; because we
> + * use a byte based buffer, we play the cast to guint32 trick (as that
> + * is what g_random_int() returns).
> + */

can we just stick with gtk-doc like you had in your previous patches. I
think intermixing it with doxygen is a bad idea.

Regards

Marcel



--===============7735480864476729145==--


Content-Type: multipart/mixed; boundary="===============1709031849798487259=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 0/2] mmsd: fix problems when unregistering msg
Date: Thu, 22 Mar 2012 13:23:49 -0700
Message-ID: <1332447829.1870.35.camel@aeonflux>
In-Reply-To: <1332434252-23551-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1709031849798487259==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ronald,

> Please find changes in mmsd in order to fix problems that occurred when
> unregistering messages.
> =

> 1) the messages table contains mms_message object and not uuid, now
> every message is unregister with its correct path when the messages
> table is destroyed. Furthermore, don't need to remove the message from
> the table using g_hash_table_foreach_remove() since
> mms_message_unregister() already removed it from the table.
> =

> 2) use the msg_path (within the debug statement) before removing the
> message from the table which free it

both patches have been applied.

Regards

Marcel



--===============1709031849798487259==--


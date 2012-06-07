Content-Type: multipart/mixed; boundary="===============8630139836837249659=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/3] doc: Describe delivered group in storage doc
Date: Thu, 07 Jun 2012 11:43:21 +0900
Message-ID: <1339037001.1817.120.camel@aeonflux>
In-Reply-To: <1338454376-12806-3-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8630139836837249659==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ronald,

>  doc/storage.txt |   30 ++++++++++++++++++++++++++++++
>  1 files changed, 30 insertions(+), 0 deletions(-)
> =

> diff --git a/doc/storage.txt b/doc/storage.txt
> index 8e76382..0aa6d9d 100644
> --- a/doc/storage.txt
> +++ b/doc/storage.txt
> @@ -18,6 +18,7 @@ Meta file Example
>  [info]
>  read=3Dfalse
>  state=3Dnotification
> +message_id=3D0123456789ABCDEF

I would just shortcut this to "id". Or is the a reason to keep
"message_id" for this?

>  Meta file Keys/Values details
> @@ -31,3 +32,32 @@ state: The message local state, possible values can be:
>      - "received": m-Retrieve.Conf PDU downloaded and successfully acknow=
ledged.
>      - "draft": m-Send.Req PDU ready for sending.
>      - "sent": m-Send.Req PDU successfully sent.
> +
> +message_id: this is the value provided in the M-Send.conf PDU (assigned =
by MMSC
> +in response to a M-Send.req message), this entry will only be created up=
on
> +M-Send.conf message reception if the delivery report was requested.
> +
> +For sent messages, a group [delivery_status] could take place in additio=
n to
> +[info] if delivery report is requested.
> +In this group, every recipient has a MMS Delivery status value which can=
 be one
> +of the following:
> +    - "none": no report has been received yet.
> +    - "expired": recipient did not retrieve the MMS before expiration.
> +    - "retrieved": MMS successfully retrieved by the recipient.
> +    - "rejected": recipient rejected the MMS.
> +    - "deferred": recipient decided to retrieve the MMS at a later time.
> +    - "indeterminate": cannot determine if the MMS reached its destinati=
on.
> +    - "forwarded": recipient forwarded the MMS without retrieving it fir=
st.
> +    - "unreachable": recipient is not reachable.
> +
> +
> +Example of a sent_message meta file with delivery report requested
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +[info]
> +state=3Dsent
> +message_id=3D0123456789ABCDEF
> +
> +[delivery_status]
> +21345=3Dretrieved
> +09876=3Dnone

How is this suppose to work. I am kinda failing to see what this tries
to solve.

Regards

Marcel



--===============8630139836837249659==--


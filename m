Content-Type: multipart/mixed; boundary="===============7615492135622326255=="
MIME-Version: 1.0
From: Miettinen Pasi <pasi.miettinen@ixonos.com>
Subject: VS: [RFC PATCH 1/4] SetProperty for UseDeliveryReports. smsutil.c/h.
Date: Mon, 07 Jun 2010 13:14:39 +0300
Message-ID: <EA8B5A37FEEFC048AF3F8170D2819913B8C1280A50@jklmail01.ixonos.local>
In-Reply-To: <1275904409-19829-2-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7615492135622326255==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> ---
>  src/smsutil.c |    5 +++--
>  src/smsutil.h |    3 ++-
>  2 files changed, 5 insertions(+), 3 deletions(-)
> |
> diff --git a/src/smsutil.h b/src/smsutil.h
> index a36a9d3..cfb2765 100644
> --- a/src/smsutil.h
> +++ b/src/smsutil.h
> @@ -482,7 +482,8 @@ GSList *sms_assembly_add_fragment(struct sms_assembly=
 *assembly,
>  void sms_assembly_expire(struct sms_assembly *assembly, time_t before);
>
>  GSList *sms_text_prepare(const char *utf8, guint16 ref,
> -                               gboolean use_16bit, int *ref_offset);
> +                               gboolean use_16bit, int *ref_offset,
> +                               const gboolean use_delivery_reports);
>
> gboolean cbs_dcs_decode(guint8 dcs, gboolean *udhi, enum sms_class *cls,
>                         enum sms_charset *charset, gboolean *compressed,

Ah, no need for const before gboolean, as Denis said. Do I need to send ano=
ther patch, or can you
remove it?

Br,
Pasi


--===============7615492135622326255==--


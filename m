Content-Type: multipart/mixed; boundary="===============7407545155784335544=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: use libqmi or .json definition for qmi calls
Date: Tue, 16 May 2017 18:14:34 +0200
Message-ID: <20170516152328.775cfd0d@lazus.yip>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7407545155784335544==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

as it get's quite exhausting to create over and over qmi messages by
hand, I'm wondered why ofono isn't using a library for it.
Is there a reason why ofono isn't using libqmi [1] or the .json [2] to
generate code like other projects does [3]?

Best,
lynxis

[1] https://www.freedesktop.org/wiki/Software/libqmi/
[2] https://cgit.freedesktop.org/libqmi/tree/data/qmi-service-wms.json
[3] https://git.lede-project.org/?p=3Dproject/uqmi.git;a=3Dtree;f=3Ddata;hb=
=3DHEAD
-- =

Alexander Couzens

mail: lynxis(a)fe80.eu
jabber: lynxis(a)fe80.eu
mobile: +4915123277221
gpg: 390D CF78 8BF9 AA50 4F8F  F1E2 C29E 9DA6 A0DF 8604

--===============7407545155784335544==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.sig"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSXpCQUVCQ2dBZEZpRUVPUTNQZUl2NXFs
QlBqL0hpd3A2ZHBxRGZoZ1FGQWxrYkpXb0FDZ2tRd3A2ZHBxRGYKaGdUc2lRLzhDSDF3bFlvRmZq
QUcydEs0WW5PcHZwWWZKNXI1SXBSMGdscUdRWVFJVmVzT0s5YW50RERuQ0p4NQpyeDVzczlSc2ZF
S0Nzek5XODl0ZGt3alpZZnd5UnJJSEo0aVRMclNoTDZTN3g5R0xTOTlzZTVvcjlxNWdRTGJnClBq
VExZbDFpSnhQRFFUUFdSNjlyaFhzL0pUaFBhbElZL3Z4U1BTa05BcTlYKzUvdnZSajJLdEI2Nm1C
bzFwcDIKeURidGhhdFVtY3B5UjJYREtNL2dzVGRJemlhVlNuZklOOFhsNitKeFBRSy9qL0NINnly
aVNWbldjVUh2Sk5PaQp6RTNnVi9Pbmh4VUpXNUxna0FDMWN5am9nTjV5Ty9jNGZtS2JqekEvTEoz
SFZaR1Vqc2Z2eWhjL1lJYSt4UVJGClFFUDRodlpUNUd2T0RiQW9WMzVjT3ZqYk9MTFdzR2RoTmZN
QTlZNHpCVFJFOUdQeC9DdHVabnFIdU4rYi9MWDAKNEtPT3ZrQ1cxRDJxNDY0ZmlrN25WS0JSenlH
L0NLbktmRnRTSk5tNDFMZSs0b2FPL3lyZVBhNHMra255Rmp3bgpxN3NyTkd3QW9VNytWRkdjeUkr
anUzcEpjeTdxWWc0T2Z6bUl0MkhkSEt4VmpDSitCK1crTThkc0xTYnRzRDlnCmFUaWVTU0hoK21P
TmdnNlpKZ2huRm9VbUNrRTlnZEhEb3N4ZEpzT1dYajlia3Nib0pDTFlFZWZYZlcwcFl5dE8KMEVj
OXlCcHl0WE1ZcG5ZaWp5UlpiMUFEK0hjVk9qaUFrUWhOVmcrMEdVeENUd1JJRDhkN2J1K0ZpVzZx
NFlvdQpEWWFMaitJdDJwUFZNdzF4ZEhOMDdpYzhyZWxZd0h2K3B1Zkd0NmM5Rm9MM0lLM0l3UW89
Cj11dis2Ci0tLS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0tLQo=

--===============7407545155784335544==--


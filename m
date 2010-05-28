Content-Type: multipart/mixed; boundary="===============1489726561710892337=="
MIME-Version: 1.0
From: Miettinen Pasi <pasi.miettinen@ixonos.com>
Subject: VS: [PATCH 04/11] Changes for SMS statur report.
Date: Fri, 28 May 2010 15:02:29 +0300
Message-ID: <EA8B5A37FEEFC048AF3F8170D2819913B8C1280A44@jklmail01.ixonos.local>
In-Reply-To: <1274960483.3755.501.camel@tucson.research.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1489726561710892337==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> On Thu, 2010-05-27 at 12:54 +0200, ext pasi.miettinen(a)ixonos.com wrote:
> > diff --git a/include/sms.h b/include/sms.h
> > index daaec37..c007675 100644
> > --- a/include/sms.h
> > +++ b/include/sms.h
> > @@ -54,7 +54,7 @@ struct ofono_sms_driver {
> >
> > void ofono_sms_deliver_notify(struct ofono_sms *sms, unsigned char *pdu,
> >                              int len, int tpdu_len);
> > -void ofono_sms_status_notify(struct ofono_sms *sms, unsigned char *pdu,
> > +void ofono_sms_status_report_notify(struct ofono_sms *sms, unsigned ch=
ar *pdu,
> >                              int len, int tpdu_len);
>
> Actually, I think we should have a single ofono_sms_pdu_notify(), and
> let the core handle demuxing the different message types after parsing
> the PDU.
>
> ISI modems don't have different messages for deliver and status report;
> the modem just sends a TPDU.
>
> Cheers,
> Aki

I made one possible solution for this and planning to test how it works aft=
er
the weekend. Hopefully I am able to send a fixing patch early next week.

Br,
Pasi

_______________________________________________
ofono mailing list
ofono(a)ofono.org
http://lists.ofono.org/listinfo/ofono



--===============1489726561710892337==--


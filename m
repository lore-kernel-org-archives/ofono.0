Content-Type: multipart/mixed; boundary="===============1019745579348243543=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v2] [RfC] doc: Proposed Set Up Call api.
Date: Wed, 18 Aug 2010 08:38:50 +0200
Message-ID: <1282113530.23399.131.camel@localhost.localdomain>
In-Reply-To: <4C6B705B.1070400@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1019745579348243543==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> > diff --git a/doc/voicecall-api.txt b/doc/voicecall-api.txt
> > index efeae42..dae3ec2 100644
> > --- a/doc/voicecall-api.txt
> > +++ b/doc/voicecall-api.txt
> > @@ -106,3 +106,14 @@ Properties	string LineIdentification [readonly]
> >  			stamped when the call enters the "active" state.
> >  			Client applications can use this to infer somewhat
> >  			reliable call duration information.
> > +
> > +		string Information [readonly, optional]
> > +
> > +			Contains information related to the call for the
> > +			user.  Currently this property is set for calls
> > +			initiated by SIM Toolkit applications.
> > +
> > +		string IconID [readonly, optional]
> > +
> > +			Icon identifier to be used instead of or together
> > +			with the text information.
> =

> So my preference here is simply Icon, or IconIdentifier.  IconID breaks
> our pure CamelCase rules for APIs.

I think we used Icons in STK API and thus this should be Icon to match
with it. But yes, either plain Icon or IconIdentifier.

Regards

Marcel



--===============1019745579348243543==--


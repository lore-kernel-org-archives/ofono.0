Content-Type: multipart/mixed; boundary="===============0591081436848720734=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: Re: [PATCH 5/5] cell-info: Documentation
Date: Wed, 29 Dec 2010 09:18:05 +0200
Message-ID: <1293607085.11345.53.camel@apaila-ThinkPad-T410>
In-Reply-To: <1293556434.9439.70.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0591081436848720734==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On Tue, 2010-12-28 at 09:13 -0800, ext Marcel Holtmann wrote:
> Hi Antti,
> =

> >  doc/cell-info.txt |  124 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  1 files changed, 124 insertions(+), 0 deletions(-)
> >  create mode 100644 doc/cell-info.txt
> > =

> > diff --git a/doc/cell-info.txt b/doc/cell-info.txt
> > new file mode 100644
> > index 0000000..b288e69
> > --- /dev/null
> > +++ b/doc/cell-info.txt
> > @@ -0,0 +1,124 @@
> > +Cell Info hierarchy
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Service		org.ofono
> > +Interface	org.ofono.CellInfo
> > +Object path	[variable prefix]/{modem0,modem1,...}
> > +
> > +Methods 	a{sv}aa{sv} GetNeighborCellInfo()
> > +
> > +			Calling this procedure returns properties of serving
> > +			and neighbouring cells in GSM or WCDMA networks. This
> > +			information can be used to determine current location
> > +			using triangulation over neighbouring cell tower
> > +			locations and estimated distances.
> > +
> > +			The return value consists of two parts: 1) dictionary
> > +			of common information about network and serving cell 2)
> > +			array of dictionaries containing measurement results
> > +			of neighbouring cells. The contents of the dictionaries
> > +			follow the specification OMA-TS-ULP-V2_0-20100816-C for
> > +			user plane Location and is described in properties
> > +			section.
> > +
> > +		a{sv} GetProperties
> > +
> > +			Calling this procedure returns properties of serving
> > +			cell in GSM or WCDMA networks. Effectively the data
> > +			returned is the part 1 of the data returned by
> > +			GetNeighborCellInfo.
> =

> why do we bother here with two methods calls. What is the use of getting
> only half of the information. You are making the same call to the
> hardware, so why not return the same information.

The GetProperties was kind of last minute glue-on but it was not without
a reason. This atom is about cell info and hence I implicitly assumed
that when you want to query the properties of a cell you would mean the
cell that is your current serving cell. Since nearly all atoms have
GetProperties method, this would be in line with oFono conventions and
services that assume that interface has GetProperties -method could
utilize the cell info. As an example, 'list-modems'-script would nicely
print the serving cell info for a modem.

If the client wants the measurement result of neighboring cells, it
needs to call the GetNeighbors method explicitly. Even if internally
these two methods lead to same hardware call, I don't believe this
should effect the design of DBUS interface, that is visible to client
applications.

That was the reasoning behind the decision to include GetProperties
-method. If you still believe it is not right I can remove the method. =


> The method name org.ofono.CellInfo.GetNeighborCellInfo is also not
> really good. I duplicates the CellInfo information. So I would just have
> called this GetNeighbors.

I agree about the naming. GetNeighbors is better.

> What is the reason behind a{sv}aa{sv} here? Wouldn't it be simpler to
> just go with aa{sv} and declare that the first dict is always the
> current serving cell? Are the information from the current cell really
> that different than from the neighbors?

The rationale is that this is the format OMA-TS-ULP-V2_0-20100816-C and
3GPP RRC define for user plane location. Also, all modems don't provide
the same information for serving and neighbor cells; e.g. isimodem
follows the above mentioned specs. I believe that for location purposes
the information included in the a{sv} part is not needed for neighbors.
Hence making the structure flat would not really make things simpler. =



> One other think that I don't really like with the GetProperties part is
> that we could expect a PropertiesChanged signal. However that is not
> really going to happen since the query should only be done on demand. So
> I would prefer if we then don't have properties at all in this case.

Agreed. Yet again, this is about interface design and what services we
want to provide for clients. I am not religiously trying to defend my
approach, but merely opening the reasons behind the implementation.

Thanks for the comments.

Best Regards,
  Antti =



--===============0591081436848720734==--


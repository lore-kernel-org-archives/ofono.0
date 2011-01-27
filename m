Content-Type: multipart/mixed; boundary="===============1945945167251713428=="
MIME-Version: 1.0
From: Kai.Vehmanen@nokia.com
Subject: RE: [RFC] doc: Proposal for LTE/IMS API.
Date: Thu, 27 Jan 2011 13:33:46 +0000
Message-ID: <C50CA21D80D6B74F80FB941E215DF4145B46DD@008-AM1MPN1-001.mgdnok.nokia.com>
In-Reply-To: <1296134046.1520.152.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1945945167251713428==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 27 Jan 2011, Marcel Holtmann wrote:
>> +		array{dict,array{dict}} QosFilters [readonly, optional]
>> +
>> +			Information about the QoSes and associated Packet
>> +			Filters for the Default PDN and it's dedicated bearers.
>> +			It is organized as a list of QoS definitions with
>> +			a list of corresponding packet filters.
> =

> We really need to understand what the IMS application will need. If
> this is about codecs or other things, then maybe oFono should give codec
> advise directly. Proposals are welcome. Right now this looks like going
> overboard.

this is used e.g. for SDP preconditions mechanism used in IMS:
http://www.faqs.org/rfcs/rfc3312.html

The QoS is signalled on a per port/media basis, so relaying =

the packet-filters seems like a sane approach to me (cannot really
say the same about 3312, but that's a different thing ;P).


--===============1945945167251713428==--


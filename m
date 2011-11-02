Content-Type: multipart/mixed; boundary="===============1318825021210850869=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: Re: [PATCH 1/1] gatchat: Add IPv6 CP support
Date: Wed, 02 Nov 2011 12:29:10 +0200
Message-ID: <4EB11B76.9020808@intel.com>
In-Reply-To: <4EAE5193.2080709@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1318825021210850869==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

On 10/31/2011 09:43 AM, Denis Kenzior wrote:
> This looks like a good start.  However, please separate this patch into
> several, like this:
>
> - One adding the bulk of IPv6CP protocol
> - One for hooks in gatppp itself&  ipv6cp
> - One for gsmdial
> - One for test-server.

Sure, will structure like that.

> Can IPV6CP and IPCP co-exist?  In theory there is such a concept as
> dual-stack contexts, however I don't know whether any modem in existence
> does this with PPP.

Incidentally, I was thinking about this too. I already made IPCP and IPv6CP=
 to =

co-exist, will post it together with corrections in the next version.

>> +void g_at_ppp_set_ipv6cp_info(GAtPPP *ppp, const char *local, const cha=
r *peer)
>> +{
>> +	struct in6_addr local_addr;
>> +	struct in6_addr peer_addr;
>> +
>> +	if (local)
>> +		inet_pton(AF_INET6, local,&local_addr);
>> +	else
>> +		memset(&local_addr, 0, sizeof(local_addr));
>> +
>
> What if inet_pton fails?

Sure, I will improve this.

>> +struct eui64 {
[...]
>> +};
>
> I really don't like this actually.  I would either simply use an
> unsigned char[8] array or use guint64.

Sure, simple guint8[8] will do.

>> +struct pppcp_data *ipv6cp_new(GAtPPP *ppp, const struct eui64 *local_ad=
dr,
>> +				const struct eui64 *peer_addr);
>
> Thinking more about it, why don't you make this function take const char
> * arguments instead, and hide away all the nasty details inside
> ipv6cp.c?  This way all these funky structs are hidden away in the
> implementation, and you can use whatever is the most convenient.

Good point, I will correct.

>> +enum ipv6cp_option_types {
>> +	IPV6CP_INTERFACE_ID		=3D 1,
>> +	IPV6CP_COMPRESSION_PROTO	=3D 2,
>
> The latest RFC 5072 doesn't even have this option, so you can probably
> get rid of it.

OK.

>> +static enum rcr_result ipv6cp_peer_addr_check(struct ipv6cp_data *ipv6c=
p,
>> +						const void *data)
>> +{
>> +	if (memcmp(&eui64_any, data, sizeof(eui64_any)) =3D=3D 0)
>> +		return RCR_NAK;
>> +
>
> If we're playing the server role, then we might want to NAK non-zero
> peer interface ids as well.

OK.

>> +static enum rcr_result ipv6cp_rcr(struct pppcp_data *pppcp,
>> +					const struct pppcp_packet *packet,
>> +					guint8 **new_options, guint16 *new_len)
>
> Is there a particular reason you did not structure this function in the
> same manner as ipcp_server/client_rcr?  They are pretty much optimized
> with no allocations on the fast (non-reject) path and I'd like to have
> consistency in the code.

I tried to simplify this a bit, and to get rid of the client-server separat=
ion, =

if possible. I missed the point that the fast path is optimized.

Anyway, thanks for the explanation, I will separate into client and server =
and =

make sure there aren't extra allocations on the fast path.

>> +static void ipv6cp_rcn_nak(struct pppcp_data *pppcp,
>> +				const struct pppcp_packet *packet)
>> +{
>> +	struct ipv6cp_data *ipv6cp =3D pppcp_get_data(pppcp);
>> +	struct ppp_option_iter iter;
>> +
>> +	ppp_option_iter_init(&iter, packet);
>> +
>
> We have to be a bit careful here, if we are playing the server role then
> we should not let the client dictate our interface ID.  The reason being
> that e.g. ConnMan might be allocating our interface ids from its own
> pool and we can't really change it at this point.

OK, thanks for the input here, I will take this into account.

>> +	while (ppp_option_iter_next(&iter) =3D=3D TRUE) {
>> +		const guint8 *data =3D ppp_option_iter_get_data(&iter);
>> +
>> +		switch (ppp_option_iter_get_type(&iter)) {
>> +		case IPV6CP_INTERFACE_ID:
>> +			memcpy(&ipv6cp->local_addr, data,
>> +				sizeof(ipv6cp->local_addr));
>
> You might also want to make sure to set the flag to request the
> interface id, though this is more of a problem with IPCP.

OK, will check this.

>> +	while (ppp_option_iter_next(&iter) =3D=3D TRUE) {
>> +		switch (ppp_option_iter_get_type(&iter)) {
>> +		case IPV6CP_INTERFACE_ID:
>> +			ipv6cp->req_options&=3D ~IPV6CP_INTERFACE_ID;
>> +			memset(&ipv6cp->local_addr, 0,
>> +				sizeof(ipv6cp->local_addr));
>
> This means that the peer refused to configure this option, it doesn't
> mean that our idea of our interface (e.g. if we're the server) should be
> reset...

Will check this too.

>> +	g_print("\ttest-server [-t type] [-6 addr]\n");
>
> Hm, this message makes no sense.

This was added for testing purposes, just in order to test if both ends can =

exchange the IDs. I will remove it, if it's not necessary.

Thanks for the comments, I will prepare and send another set.

Regards,
Oleg
-- =

Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki
Business Identity Code: 0357606 - 4
Domiciled in Helsinki


--===============1318825021210850869==--


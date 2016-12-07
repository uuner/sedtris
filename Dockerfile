FROM busybox

ADD sedtris.sh sedtris.sed /

CMD ["sh", "/sedtris.sh"]

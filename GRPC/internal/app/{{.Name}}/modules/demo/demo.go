package demo

import (
	proto "{{.Name}}/api/protobuf-spec/demo"
	"context"
)

// GrpcServer implementation
type GrpcServer struct{}

// SayHello implementation for demo.proto
func (s *GrpcServer) SayHello(ctx context.Context, r *proto.SayHelloReq) (*proto.SayHelloResp, error) {
	return &proto.SayHelloResp{Ok: true}, nil
}
